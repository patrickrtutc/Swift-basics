//
//  ViewController.swift
//  UITableViewDemo
//
//  Created by Patrick Tung on 2/14/25.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let navigationBar = UINavigationBar()
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    let sections = ["System Settings", "Features"]
    let settings = [
        [["General", "gearshape.fill"],
         ["Accessibility", "accessibility"],
         ["Action Button", "arrow.right.square.fill"],
         ["Camera", "camera.fill"],
         ["Home Screen & App Library", "square.grid.2x2.fill"],
         ["Search", "magnifyingglass"],
         ["StandBy", "bed.double.fill"]],
        [["Screen Time", "hourglass"],
         ["Privacy & Security", "hand.raised.fill"]]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
                
        setupNavigationBar()
        title = "Settings"
        setupTableView()
    }
    
    func setupNavigationBar() {
        view.addSubview(navigationBar)
                
        // Create a UINavigationItem
            let navItem = UINavigationItem()
            
            // Create a custom title label with padding
            let titleLabel = UILabel()
            titleLabel.text = "Settings"
            titleLabel.font = UIFont.boldSystemFont(ofSize: 34) // Matches large title font
            titleLabel.textColor = .label
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            
            let titleContainerView = UIView()
            titleContainerView.addSubview(titleLabel)
            titleContainerView.translatesAutoresizingMaskIntoConstraints = false
            
            // Shift text to the right
            NSLayoutConstraint.activate(
[
                titleLabel.leadingAnchor
                    .constraint(
                        equalTo: titleContainerView.leadingAnchor,
                        constant: 4
                    ),
                titleLabel.trailingAnchor.constraint(equalTo: titleContainerView.trailingAnchor),
                titleLabel.widthAnchor.constraint(equalToConstant: 500),
                titleLabel.heightAnchor.constraint(equalToConstant: 120),
            ]
)
            
            navItem.titleView = titleContainerView
            navigationBar.setItems([navItem], animated: false)
            
            navigationBar.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                navigationBar.heightAnchor.constraint(equalToConstant: 88)
            ])
            
            navigationBar.prefersLargeTitles = true
            navigationBar.clipsToBounds = true
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SettingsCell.self, forCellReuseIdentifier: "SettingsCell")
        tableView.rowHeight = 44
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return sections[section]
//    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let setting = settings[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as! SettingsCell
        cell.configure(title: setting[0], iconName: setting[1])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

class SettingsCell: UITableViewCell {
    
    private let iconContainer: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        return view
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        contentView.addSubview(iconContainer)
        iconContainer.addSubview(iconImageView)
        contentView.addSubview(label)
        
        iconContainer.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            iconContainer.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            iconContainer.widthAnchor.constraint(equalToConstant: 30),
            iconContainer.heightAnchor.constraint(equalToConstant: 30),
            
            iconImageView.centerXAnchor.constraint(equalTo: iconContainer.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: iconContainer.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 20),
            iconImageView.heightAnchor.constraint(equalToConstant: 20),
            
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: iconContainer.trailingAnchor, constant: 15),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
        ])
    }
    
    func configure(title: String, iconName: String) {
        label.text = title
        iconImageView.image = UIImage(systemName: iconName)
        iconContainer.backgroundColor = getIconBackgroundColor(for: title)
        iconContainer.layer.cornerRadius = 6
    }
    
    private func getIconBackgroundColor(for title: String) -> UIColor {
        switch title {
        case "General": return .systemGray
        case "Accessibility": return .systemBlue
        case "Action Button": return .systemBlue
        case "Camera": return .systemGray
        case "Home Screen & App Library": return .systemBlue
        case "Search": return .systemGray
        case "StandBy": return .black
        case "Screen Time": return .systemPurple
        case "Privacy & Security": return .systemBlue
        default: return .systemBlue
        }
    }
}
