import UIKit

class NoteEditViewController: UIViewController {
    private let viewModel: NoteEditViewModel
    private var output: NoteEditViewModel.Output?
    
    private let titleTextField = UITextField()
    private let contentTextView = UITextView()
    
    var onCompletionHandler: (() -> Void)?
    
    init(viewModel: NoteEditViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        output = viewModel.transform(input: NoteEditViewModel.Input(
            viewDidLoad: (),
            saveNote: (title: "", content: "")
        ))
        
        updateUI()
    }
    
    private func setupUI() {
        title = output?.isEditing == true ? "Edit Note" : "New Note"
        view.backgroundColor = .systemBackground
        
        // Configure navigation bar buttons
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .save,
            target: self,
            action: #selector(saveButtonTapped)
        )
        
        // Configure title text field
        titleTextField.placeholder = "Title"
        titleTextField.font = UIFont.boldSystemFont(ofSize: 20)
        titleTextField.borderStyle = .roundedRect
        titleTextField.clearButtonMode = .whileEditing
        
        // Configure content text view
        contentTextView.font = UIFont.systemFont(ofSize: 16)
        contentTextView.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        contentTextView.layer.borderColor = UIColor.systemGray4.cgColor
        contentTextView.layer.borderWidth = 1
        contentTextView.layer.cornerRadius = 8
        
        // Add subviews
        let stackView = UIStackView(arrangedSubviews: [titleTextField, contentTextView])
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
            
            titleTextField.heightAnchor.constraint(equalToConstant: 44),
            contentTextView.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor, multiplier: 0.5)
        ])
    }
    
    private func updateUI() {
        guard let output = output else { return }
        
        titleTextField.text = output.title
        contentTextView.text = output.content
    }
    
    @objc private func saveButtonTapped() {
        guard let title = titleTextField.text, !title.isEmpty else {
            showAlert(message: "Please enter a title for your note")
            return
        }
        
        // First ensure the keyboard is dismissed to avoid UI glitches
        view.endEditing(true)
        
        if viewModel.saveNote(title: title, content: contentTextView.text) {
            // Post notification to update notes list
            NotificationCenter.default.post(name: Notification.Name("NoteDataDidChange"), object: nil)
            
            // Small delay to ensure CoreData has finished saving before navigating back
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
                self?.onCompletionHandler?()
            }
        } else {
            showAlert(message: "Failed to save your note. Please try again.")
        }
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
} 