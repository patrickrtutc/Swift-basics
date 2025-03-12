import Foundation

class NoteEditViewModel: ViewModelType {
    private let coreDataService: CoreDataServiceType
    private let note: Note?
    
    struct Input {
        let viewDidLoad: Void
        let saveNote: (title: String, content: String)
    }
    
    struct Output {
        let title: String
        let content: String
        let isEditing: Bool
        let onSaveSuccess: () -> Void
    }
    
    private var onSaveSuccessHandler: (() -> Void)?
    
    init(coreDataService: CoreDataServiceType, note: Note?) {
        self.coreDataService = coreDataService
        self.note = note
    }
    
    func transform(input: Input) -> Output {
        let output = Output(
            title: note?.title ?? "",
            content: note?.content ?? "",
            isEditing: note != nil,
            onSaveSuccess: { [weak self] in
                self?.onSaveSuccessHandler?()
            }
        )
        
        onSaveSuccessHandler = { 
            // Empty handler to be set by the view controller
        }
        
        return output
    }
    
    func saveNote(title: String, content: String) -> Bool {
        if let note = note {
            return coreDataService.updateNote(note, title: title, content: content)
        } else {
            return coreDataService.saveNote(title: title, content: content) != nil
        }
    }
} 