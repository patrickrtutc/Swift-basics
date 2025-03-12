import UIKit

class NotesListViewController: UIViewController {
    private let viewModel: NotesListViewModel
    private let tableView = UITableView()
    private var output: NotesListViewModel.Output?
    
    // Local reference to the notes array
    private var notes: [Note] = []
    
    var onNoteSelected: ((Note) -> Void)?
    var onAddNoteSelected: (() -> Void)?
    
    init(viewModel: NotesListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        output = viewModel.transform(input: NotesListViewModel.Input(
            viewDidLoad: (),
            didSelectDelete: 0
        ))
        
        // Setup binding to notes
        output?.notesBinding.bind { [weak self] notes in
            self?.notes = notes
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        // Add observers for notes update
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableView), name: UIScene.didActivateNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableView), name: Notification.Name("NoteDataDidChange"), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadData()
    }
    
    private func reloadData() {
        output?.reloadData()
    }
    
    @objc private func reloadTableView() {
        reloadData()
    }
    
    private func setupUI() {
        title = "Notes"
        view.backgroundColor = .systemBackground
        
        // Add a button to create a new note
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addNoteButtonTapped)
        )
        
        // Setup table view
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "NoteCell")
        
        // Add table view to view hierarchy
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc private func addNoteButtonTapped() {
        onAddNoteSelected?()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension NotesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath)
        
        let note = notes[indexPath.row]
        var config = cell.defaultContentConfiguration()
        config.text = note.title ?? "Untitled"
        
        if let content = note.content, !content.isEmpty {
            config.secondaryText = content.prefix(50) + (content.count > 50 ? "..." : "")
        }
        
        cell.contentConfiguration = config
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let note = viewModel.noteAt(index: indexPath.row) {
            onNoteSelected?(note)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if viewModel.deleteNote(at: indexPath.row) {
                // The binding will automatically update the table view
            }
        }
    }
} 
