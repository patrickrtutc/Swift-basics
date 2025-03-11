//
//  CoreDataManager.swift
//  DigimonAPISwiftUICombine
//
//  Created by Patrick Tung on 3/10/25.
//

import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    let container: NSPersistentContainer
    
    private init() {
        container = NSPersistentContainer(name: "DigimonAPISwiftUICombine") // Make sure this matches your .xcdatamodeld file name
        container.loadPersistentStores { _, error in
            if let error = error {
                print("Core Data failed to load: \(error)")
            }
        }
    }
    
    func saveDigimons(_ digimons: [Digimon]) {
        let context = container.viewContext
        context.perform {
            // Clear existing data
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = DigimonEntity.fetchRequest()
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            _ = try? context.execute(deleteRequest)
            
            // Save new data
            for digimon in digimons {
                let entity = DigimonEntity(context: context)
                entity.name = digimon.name
                entity.img = digimon.img
                entity.level = digimon.level
            }
            
            try? context.save()
        }
    }
    
    func fetchDigimons() -> [Digimon] {
        let context = container.viewContext
        let request = DigimonEntity.fetchRequest()
        
        guard let entities = try? context.fetch(request) else { return [] }
        return entities.map { Digimon(name: $0.name ?? "", img: $0.img ?? "", level: $0.level ?? "") }
    }
}
