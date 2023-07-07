//
//  ToDoList.swift
//  ToDo
//
//  Created by Руслан on 21.06.2023.
//

import Foundation
import CoreData

class ToDoService {
    private init() { }
    static let instance = ToDoService()
    
    @Published
    private(set) var items: [ToDoItem] = []
    
    func updateItemListFromCoreData() {
        items = CoreDataManager.shared.getAllItems().map(ToDoItem.init)
    }
    
    func createItem(withContent content: String) {
        let item = ToDoItemCD(context: CoreDataManager.shared.viewContext)
        item.id = UUID().uuidString
        item.content = content
        item.date = Date()
        item.isFavorite = false
        item.isCompleted = false
        
        CoreDataManager.shared.save()
        updateItemListFromCoreData()
// Without Core Data       items.append(ToDoItem(content: content))
    }
    
    func removeItem(byId id: NSManagedObjectID) {
        items.forEach { el in
            if el.id == id { CoreDataManager.shared.delete(el.item) }
        }
        
        CoreDataManager.shared.save()
        updateItemListFromCoreData()
        
        // Without Core Data       items.removeAll(where: { $0.id == id })
    }
    
    private func updateItemField(byItemId id: NSManagedObjectID, action: (Int) -> Void) {
        guard let index = items.firstIndex(where: { $0.id == id })
        else {
            return
        }
                
        action(index)
    }
    
    private func saveToCoreData() {
        
    }
    
//    func updateItem(_ content: String, forItemWithId id: String) {
//        updateItemField(byItemId: id) { index in
//            items[index].content = content
//        }
//    }
//
//    func setFavorites(byItemId id: String, newState isFavorite: Bool) {
//        updateItemField(byItemId: id) { index in
//            items[index].isFavorite = isFavorite
//        }
//    }
//
//    func setCompletion(byItemId id: String, newState isCompleted: Bool) {
//        updateItemField(byItemId: id) { index in
//            items[index].isCompleted = isCompleted
//        }
//    }
//
//    func toggleFavorite(byItemId id: String) {
//        updateItemField(byItemId: id) { index in
//            items[index].isFavorite.toggle()
//        }
//    }
//
//    func toggleCompletion(byItemId id: String) {
//        updateItemField(byItemId: id) { index in
//            items[index].isCompleted.toggle()
//        }
//    }
}

