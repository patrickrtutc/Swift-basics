import UIKit

class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    private let coreDataService: CoreDataServiceType
    
    init(navigationController: UINavigationController, coreDataService: CoreDataServiceType = CoreDataService()) {
        self.navigationController = navigationController
        self.coreDataService = coreDataService
    }
    
    func start() {
        showNotesList()
    }
    
    private func showNotesList() {
        let viewModel = NotesListViewModel(coreDataService: coreDataService)
        let notesListVC = NotesListViewController(viewModel: viewModel)
        
        notesListVC.onNoteSelected = { [weak self] note in
            self?.showNoteDetail(note: note)
        }
        
        notesListVC.onAddNoteSelected = { [weak self] in
            self?.showNoteCreation()
        }
        
        navigationController.pushViewController(notesListVC, animated: true)
    }
    
    private func showNoteDetail(note: Note) {
        let viewModel = NoteDetailViewModel(coreDataService: coreDataService, note: note)
        let noteDetailVC = NoteDetailViewController(viewModel: viewModel)
        
        noteDetailVC.onEditNote = { [weak self] note in
            self?.showNoteEdit(note: note)
        }
        
        navigationController.pushViewController(noteDetailVC, animated: true)
    }
    
    private func showNoteCreation() {
        let viewModel = NoteEditViewModel(coreDataService: coreDataService, note: nil)
        let noteEditVC = NoteEditViewController(viewModel: viewModel)
        
        noteEditVC.onCompletionHandler = { [weak self] in
            self?.navigationController.popViewController(animated: true)
        }
        
        navigationController.pushViewController(noteEditVC, animated: true)
    }
    
    private func showNoteEdit(note: Note) {
        let viewModel = NoteEditViewModel(coreDataService: coreDataService, note: note)
        let noteEditVC = NoteEditViewController(viewModel: viewModel)
        
        noteEditVC.onCompletionHandler = { [weak self] in
            self?.navigationController.popViewController(animated: true)
        }
        
        navigationController.pushViewController(noteEditVC, animated: true)
    }
} 