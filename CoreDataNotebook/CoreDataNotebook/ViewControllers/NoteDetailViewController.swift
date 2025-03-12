import UIKit

class NoteDetailViewController: UIViewController {
    private let viewModel: NoteDetailViewModel
    private var output: NoteDetailViewModel.Output?
    
    private let titleLabel = UILabel()
    private let contentTextView = UITextView()
    private let lastUpdatedLabel = UILabel()
    
    var onEditNote: ((Note) -> Void)?
    
    init(viewModel: NoteDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        output = viewModel.transform(input: NoteDetailViewModel.Input(viewDidLoad: ()))
        updateUI()
    }
    
    private func setupUI() {
        title = "Note"
        view.backgroundColor = .systemBackground
        
        // Configure navigation bar buttons
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .edit,
            target: self,
            action: #selector(editButtonTapped)
        )
        
        // Configure title label
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .left
        
        // Configure content text view
        contentTextView.font = UIFont.systemFont(ofSize: 16)
        contentTextView.isEditable = false
        contentTextView.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        contentTextView.backgroundColor = .systemGray6
        contentTextView.layer.cornerRadius = 8
        
        // Configure last updated label
        lastUpdatedLabel.font = UIFont.systemFont(ofSize: 12)
        lastUpdatedLabel.textColor = .secondaryLabel
        lastUpdatedLabel.textAlignment = .right
        
        // Add subviews
        let stackView = UIStackView(arrangedSubviews: [titleLabel, contentTextView, lastUpdatedLabel])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .fill
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            
            contentTextView.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor, multiplier: 0.5)
        ])
    }
    
    private func updateUI() {
        guard let output = output else { return }
        
        titleLabel.text = output.title
        contentTextView.text = output.content
        lastUpdatedLabel.text = output.lastUpdated
    }
    
    @objc private func editButtonTapped() {
        onEditNote?(viewModel.getNote())
    }
} 