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
    private let CDManager = CoreDataManager.shared
    
    @Published
    private(set) var items: [ToDoItem] = []
    
    
    func createItem(withContent content: String) {
        let item = ToDoItemCD(context: CDManager.viewContext)
        item.content = content
        item.creationDate = Date()
        item.date = Date()
        
        CDManager.save()
        updateItemListFromCoreData()
        
        // Without Core Data       items.append(ToDoItem(content: content))
    }
    
    func removeItem(byId id: NSManagedObjectID) {
        guard let item = CDManager.getItem(byId: id) else {
            return
        }
        
        CDManager.delete(item)
        
        updateItemListFromCoreData()
        
        // Without Core Data       items.removeAll(where: { $0.id == id })
    }
    
    func updateItemListFromCoreData() {
        items = CDManager.getAllItems().map(ToDoItem.init)
    }
    
    func updateItem(_ content: String, forItemWithId id: NSManagedObjectID) {
        CDManager.updateItemField(byId: id, forKey: "content", value: content)
        CDManager.updateItemField(byId: id, forKey: "date", value: Date())
        
        updateItemListFromCoreData()
    //        updateItemField(byItemId: id) { index in
    //            items[index].content = content
    //        }
    }

    func setFavorites(byItemId id: NSManagedObjectID, newState isFavorite: Bool) {
        CDManager.updateItemField(byId: id, forKey: "isFavorite", value: isFavorite)

        updateItemListFromCoreData()
        
    //        updateItemField(byItemId: id) { index in
    //            items[index].isFavorite = isFavorite
    //        }
    }

    func setCompletion(byItemId id: NSManagedObjectID, newState isCompleted: Bool) {
        CDManager.updateItemField(byId: id, forKey: "isCompleted", value: isCompleted)

        updateItemListFromCoreData()
        
    //        updateItemField(byItemId: id) { index in
    //            items[index].isCompleted = isCompleted
    //        }
    }

    func toggleFavorite(byItemId id: NSManagedObjectID) {
        
        guard let item = CDManager.getItem(byId: id) else {
            return
        }

        CDManager.updateItemField(byId: id, forKey: "isFavorite", value: !item.isFavorite)
        
        updateItemListFromCoreData()
        
    //        updateItemField(byItemId: id) { index in
    //            items[index].isFavorite.toggle()
    //        }
    }

    func toggleCompletion(byItemId id: NSManagedObjectID) {
        guard let item = CDManager.getItem(byId: id) else {
            return
        }

        CDManager.updateItemField(byId: id, forKey: "isCompleted", value: !item.isCompleted)
        
        updateItemListFromCoreData()
        
    //        updateItemField(byItemId: id) { index in
    //            items[index].isCompleted.toggle()
    //        }
    }
    
    //    private func updateItemField(byItemId id: NSManagedObjectID, action: (Int) -> Void) {
    //        guard let index = items.firstIndex(where: { $0.id == id })
    //        else {
    //            return
    //        }
    //
    //        action(index)
    //    }
}

