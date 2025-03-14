//
//  ViewController.swift
//  SearchableCountryListUIKitCombine
//
//  Created by Patrick Tung on 2/28/25.
//

import UIKit
import Combine
import SwiftUI

class CountryListViewController: UIViewController {
    // UI Components
    private let tableView = UITableView()
    private let searchBar = UISearchBar()
    private let activityIndicator = UIActivityIndicatorView(style: .medium)
    
    // ViewModel and Combine storage
    private let viewModel: CountryListViewModel
    private var cancellables = Set<AnyCancellable>()
    
    init(viewModel: CountryListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        let networkManager = NetworkManager()
        let repository = CountryRepository(networkManager: networkManager)
        self.viewModel = CountryListViewModel(repository: repository)
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        viewModel.fetchCountries()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(searchBar)
        view.addSubview(tableView)
        
        // Setup activity indicator
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        
        // Constraints
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        // Configure table view
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CountryCell.self, forCellReuseIdentifier: "CountryCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 88
        
        // Configure search bar
        searchBar.delegate = self
        searchBar.placeholder = "Search countries"
    }
    
    private func bindViewModel() {
        // Bind filtered countries for table updates
        viewModel.$filteredCountries
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
        
        // Bind loading state
        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                if isLoading {
                    self?.activityIndicator.startAnimating()
                } else {
                    self?.activityIndicator.stopAnimating()
                }
            }
            .store(in: &cancellables)
        
        // Bind error messages
        viewModel.$errorMessage
            .receive(on: DispatchQueue.main)
            .compactMap { $0 }
            .sink { [weak self] errorMessage in
                self?.showErrorAlert(message: errorMessage)
            }
            .store(in: &cancellables)
    }
    
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(
            title: "Error",
            message: message,
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(
            title: "Retry",
            style: .default,
            handler: { [weak self] _ in
                self?.viewModel.fetchCountries()
            }
        ))
        
        alert.addAction(UIAlertAction(
            title: "OK",
            style: .cancel
        ))
        
        present(alert, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension CountryListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.filteredCountries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath) as! CountryCell
        let country = viewModel.filteredCountries[indexPath.row]
        cell.configure(with: country)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension CountryListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let country = viewModel.filteredCountries[indexPath.row]
        
        let detailView = CountryDetailView(country: country)
        let hostingController = UIHostingController(rootView: detailView)
        navigationController?.pushViewController(hostingController, animated: true)
    }
}

// MARK: - UISearchBarDelegate
extension CountryListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchText = searchText
    }
}

// MARK: - CountryCell
class CountryCell: UITableViewCell {
    private let nameLabel = UILabel()
    private let capitalLabel = UILabel()
    private let regionLabel = UILabel()
    private let currencyLabel = UILabel()
    private let flagImageView = UIImageView()
    private var imageLoadTask: Task<Void, Never>?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageLoadTask?.cancel()
        flagImageView.image = nil
    }
    
    private func setupCell() {
        // Configure labels
        nameLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        capitalLabel.font = .systemFont(ofSize: 14)
        capitalLabel.textColor = .darkGray
        regionLabel.font = .systemFont(ofSize: 14)
        regionLabel.textColor = .darkGray
        currencyLabel.font = .systemFont(ofSize: 14)
        currencyLabel.textColor = .darkGray
        
        // Configure flag image view
        flagImageView.contentMode = .scaleAspectFit
        flagImageView.clipsToBounds = true
        flagImageView.layer.cornerRadius = 4
        
        // Add subviews
        let infoStack = UIStackView(arrangedSubviews: [nameLabel, capitalLabel, regionLabel, currencyLabel])
        infoStack.axis = .vertical
        infoStack.spacing = 2
        
        let mainStack = UIStackView(arrangedSubviews: [flagImageView, infoStack])
        mainStack.spacing = 12
        mainStack.alignment = .center
        
        contentView.addSubview(mainStack)
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            flagImageView.widthAnchor.constraint(equalToConstant: 64),
            flagImageView.heightAnchor.constraint(equalToConstant: 48),
            
            mainStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }
    
    func configure(with country: Country) {
        nameLabel.text = country.name
        capitalLabel.text = "Capital: \(country.capital)"
        regionLabel.text = "Region: \(country.region)"
        
        let currencyInfo = [
            country.currency.name,
            country.currency.code,
            country.currency.symbol
        ].compactMap { $0 }.joined(separator: " • ")
        currencyLabel.text = "Currency: \(currencyInfo)"
        
        // Load flag image asynchronously
        imageLoadTask?.cancel()
        imageLoadTask = Task {
            if let url = URL(string: country.flagPNG),
               let (data, _) = try? await URLSession.shared.data(from: url),
               let image = UIImage(data: data) {
                await MainActor.run {
                    self.flagImageView.image = image
                }
            }
        }
    }
} 