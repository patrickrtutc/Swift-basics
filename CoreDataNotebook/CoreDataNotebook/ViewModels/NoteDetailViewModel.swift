import Foundation

class NoteDetailViewModel: ViewModelType {
    private let coreDataService: CoreDataServiceType
    private let note: Note
    
    struct Input {
        let viewDidLoad: Void
    }
    
    struct Output {
        let title: String
        let content: String
        let lastUpdated: String
    }
    
    init(coreDataService: CoreDataServiceType, note: Note) {
        self.coreDataService = coreDataService
        self.note = note
    }
    
    func transform(input: Input) -> Output {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        
        let lastUpdated = note.updatedAt != nil ? dateFormatter.string(from: note.updatedAt!) : "Not available"
        
        return Output(
            title: note.title ?? "Untitled",
            content: note.content ?? "",
            lastUpdated: "Last updated: \(lastUpdated)"
        )
    }
    
    func getNote() -> Note {
        return note
    }
    
    func deleteNote() -> Bool {
        return coreDataService.deleteNote(note)
    }
} 