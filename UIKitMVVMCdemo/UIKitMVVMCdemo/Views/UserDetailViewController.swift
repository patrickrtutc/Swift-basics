import UIKit

class UserDetailViewController: UIViewController {
    private let viewModel: UserDetailViewModel
    
    private let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .center
        return stackView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private let ageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        return label
    }()
    
    private let idLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.textColor = .gray
        return label
    }()
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(NSLocalizedString("GoBackButtonTitle", comment: "Go Back"), for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return button
    }()
    
    init(viewModel: UserDetailViewModel) {
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
        bindViewModel()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        title = NSLocalizedString("UserDetailsTitle", comment: "User Details")
        
        containerStackView.addArrangedSubview(nameLabel)
        containerStackView.addArrangedSubview(ageLabel)
        containerStackView.addArrangedSubview(idLabel)
        containerStackView.addArrangedSubview(backButton)
        
        view.addSubview(containerStackView)
        
        NSLayoutConstraint.activate([
            containerStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerStackView.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20),
            containerStackView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20),
            
            backButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 200),
            backButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureActions() {
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    private func bindViewModel() {
        nameLabel.text = viewModel.userName
        ageLabel.text = viewModel.userAge
        idLabel.text = viewModel.userId
    }
    
    @objc private func backButtonTapped() {
        viewModel.navigateBack()
    }
} 