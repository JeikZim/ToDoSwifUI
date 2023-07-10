//
//  ToDoListItem.swift
//  ToDo
//
//  Created by Руслан on 23.06.2023.
//

import Foundation
import CoreData

struct ToDoItem: Identifiable, Hashable {
    let item: ToDoItemCD
    
    var id: NSManagedObjectID {
        return item.objectID
    }
    
    var content: String {
        return item.content ?? ""
    }
    
    var date: Date {
        return item.date ?? Date()
    }
    
    var creationDate: Date {
        return item.creationDate ?? Date()
    }
    
    var isCompleted: Bool {
        return item.isCompleted
    }
    
    var isFavorite: Bool {
        return item.isFavorite
    }
    
//    let id: String
//    let date: Date
//    var content: String
//    var isCompleted: Bool
//    var isFavorite: Bool
//
//    init (id: String = UUID().uuidString, content: String) {
//        self.id = id
//        self.content = content
//        self.date = Date()
//        self.isCompleted = false
//        self.isFavorite = false
//    }

    //    init (item: ToDoItemCD) {
    //        self.id = item.id ?? UUID().uuidString
    //        self.content = item.content ?? ""
    //        self.date = item.date ?? Date()
    //        self.isCompleted = item.isCompleted
    //        self.isFavorite = item.isFavorite
    //    }
}


#if DEBUG
extension ToDoItem {
    static func mockItem1() -> ToDoItem {
        let item = ToDoItemCD(context: CoreDataManager.shared.viewContext)
        
        item.content = "Small"
        
        return ToDoItem(item: item)
    }
    static func mockItem2() -> ToDoItem {
        let item = ToDoItemCD(context: CoreDataManager.shared.viewContext)
        
        item.content = "Medium lorem ipsum and some text bla bla bla..."
        
        return ToDoItem(item: item)
    }
    static func mockItems() -> [ToDoItem] {
        [mockItem1(), mockItem2()]
    }

}
#endif
