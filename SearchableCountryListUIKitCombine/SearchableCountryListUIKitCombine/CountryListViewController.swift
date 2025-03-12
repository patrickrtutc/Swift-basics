//
//  ViewController.swift
//  SearchableCountryListUIKitCombine
//
//  Created by Patrick Tung on 2/28/25.
//

import UIKit
import Combine

class CountryListViewController: UIViewController {
    // UI Components
    private let tableView = UITableView()
    private let searchBar = UISearchBar()
    
    // ViewModel and Combine storage
    private let viewModel: CountryListViewModel
    private var cancellables = Set<AnyCancellable>()
    
       
    init(viewModel: CountryListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        self.viewModel = CountryListViewModel(networkManager: NetworkManager())
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        viewModel.fetchCountries() // Fetch data on load
    }
    
    // Set up the UI layout
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(searchBar)
        view.addSubview(tableView)
        
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
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // Configure table view
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CountryCell")
        
        // Configure search bar
        searchBar.delegate = self
    }
    
    // Bind ViewModel publishers to UI updates
    private func bindViewModel() {
        viewModel.$filteredCountries
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
    }
}

// UITableViewDataSource
extension CountryListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.filteredCountries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath)
        let country = viewModel.filteredCountries[indexPath.row]
        cell.textLabel?.text = country.name // Display only the country name
        return cell
    }
}

extension CountryListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let country = viewModel.filteredCountries[indexPath.row]
        print("Selected country: \(country.name)")
    }
}
// UISearchBarDelegate
extension CountryListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchText = searchText // Update ViewModel with search input
    }
}

