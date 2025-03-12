import Foundation

class NotesListViewModel: ViewModelType {
    private let coreDataService: CoreDataServiceType
    
    struct Input {
        let viewDidLoad: Void
        let didSelectDelete: (Int)
    }
    
    struct Output {
        var notesBinding: NotesBinding
        var reloadData: () -> Void
    }
    
    // NotesBinding class to provide reactive behavior
    class NotesBinding {
        var value: [Note] = [] {
            didSet {
                valueChanged?(value)
            }
        }
        
        var valueChanged: (([Note]) -> Void)?
        
        init(value: [Note] = []) {
            self.value = value
        }
        
        func bind(_ listener: @escaping ([Note]) -> Void) {
            valueChanged = listener
            listener(value) // Initial call with current value
        }
    }
    
    private let notesBinding = NotesBinding()
    
    init(coreDataService: CoreDataServiceType) {
        self.coreDataService = coreDataService
    }
    
    func transform(input: Input) -> Output {
        loadNotes()
        
        let output = Output(
            notesBinding: notesBinding,
            reloadData: { [weak self] in
                self?.refreshNotes()
            }
        )
        
        return output
    }
    
    private func loadNotes() {
        notesBinding.value = coreDataService.fetchNotes()
    }
    
    private func refreshNotes() {
        notesBinding.value = coreDataService.fetchNotes()
    }
    
    func deleteNote(at index: Int) -> Bool {
        guard index < notesBinding.value.count else { return false }
        
        let note = notesBinding.value[index]
        let success = coreDataService.deleteNote(note)
        if success {
            refreshNotes()
        }
        return success
    }
    
    func noteAt(index: Int) -> Note? {
        guard index < notesBinding.value.count else { return nil }
        return notesBinding.value[index]
    }
} 
