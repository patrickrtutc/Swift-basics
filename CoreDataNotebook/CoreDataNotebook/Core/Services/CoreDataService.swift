import CoreData
import UIKit

protocol CoreDataServiceType {
    func fetchNotes() -> [Note]
    func saveNote(title: String, content: String) -> Note?
    func updateNote(_ note: Note, title: String, content: String) -> Bool
    func deleteNote(_ note: Note) -> Bool
}

class CoreDataService: CoreDataServiceType {
    private let container: NSPersistentContainer
    
    init(container: NSPersistentContainer? = nil) {
        self.container = container ?? (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    }
    
    private var context: NSManagedObjectContext {
        return container.viewContext
    }
    
    func fetchNotes() -> [Note] {
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "updatedAt", ascending: false)]
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Error fetching notes: \(error)")
            return []
        }
    }
    
    func saveNote(title: String, content: String) -> Note? {
        let note = Note(context: context)
        note.id = UUID()
        note.title = title
        note.content = content
        let now = Date()
        note.createdAt = now
        note.updatedAt = now
        
        do {
            try context.save()
            return note
        } catch {
            print("Error saving note: \(error)")
            return nil
        }
    }
    
    func updateNote(_ note: Note, title: String, content: String) -> Bool {
        note.title = title
        note.content = content
        note.updatedAt = Date()
        
        do {
            try context.save()
            return true
        } catch {
            print("Error updating note: \(error)")
            return false
        }
    }
    
    func deleteNote(_ note: Note) -> Bool {
        context.delete(note)
        
        do {
            try context.save()
            return true
        } catch {
            print("Error deleting note: \(error)")
            return false
        }
    }
} 