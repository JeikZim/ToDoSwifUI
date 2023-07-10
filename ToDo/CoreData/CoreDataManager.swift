//
//  CoreDataManager.swift
//  ToDo
//
//  Created by Руслан on 07.07.2023.
//

import CoreData

class CoreDataManager {
    let persistentContainer: NSPersistentContainer
    
    static let shared = CoreDataManager()
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    init() {
        persistentContainer = NSPersistentContainer(name: "ToDoListModel")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Unable to initialize Core Data Stack \(error)")
            }
        }
    }
   
    func getItem(byId id: NSManagedObjectID) -> ToDoItemCD? {
        do {
            return try viewContext.existingObject(with: id) as? ToDoItemCD
        } catch {
            return nil
        }
    }
    
    func getAllItems() -> [ToDoItemCD] {
        let request: NSFetchRequest<ToDoItemCD> = ToDoItemCD.fetchRequest()
    
        do {
            return try viewContext.fetch(request)
        } catch let error { 
            print(error)
            return []
        }
    }
    
    func updateItemField(byId id: NSManagedObjectID, forKey key: String, value: Any?) {
        do {
            try viewContext
                .existingObject(with: id)
                .setValue(value, forKey: key)
            save()
        } catch let error {
            print("Error with updating: \(error)")
        }
    }
    
    func delete(_ task: ToDoItemCD) {
        viewContext.delete(task)
        save()
    }
    
    func save() {
        do {
            try viewContext.save()
        } catch let error {
            viewContext.rollback()
            print(error.localizedDescription)
        }
    }
}
