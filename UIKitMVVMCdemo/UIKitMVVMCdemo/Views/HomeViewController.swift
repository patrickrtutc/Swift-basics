import UIKit

class HomeViewController: UIViewController {
    private let viewModel: HomeViewModel
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "MVVM-C Demo"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NSLocalizedString(
            "HomeViewGreeting",
            comment: "HomeViewGreeting"
        )
        

        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let userListButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("View User List", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return button
    }()
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureActions()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        title = "Home"
        
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(userListButton)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            userListButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userListButton.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 60),
            userListButton.widthAnchor.constraint(equalToConstant: 200),
            userListButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureActions() {
        userListButton.addTarget(self, action: #selector(userListButtonTapped), for: .touchUpInside)
    }
    
    @objc private func userListButtonTapped() {
        viewModel.navigateToUserList()
    }
} 
