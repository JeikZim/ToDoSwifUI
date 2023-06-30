//
//  ToDoListItem.swift
//  ToDo
//
//  Created by Руслан on 23.06.2023.
//

import Foundation

struct ToDoItem: Identifiable, Hashable {
    let id: String
    let date: Date
    var content: String
    var isCompleted: Bool
    
    init (id: String = UUID().uuidString, content: String) {
        self.id = id
        self.content = content
        self.date = Date()
        self.isCompleted = false
    }
}


#if DEBUG
extension ToDoItem {
    
    static func mockItem1() -> ToDoItem {
        ToDoItem(content: "Small")
    }
    static func mockItem2() -> ToDoItem {
        ToDoItem(content: "Medium lorem ipsum and some text bla bla bla...")
    }
    static func mockItems() -> [ToDoItem] {
        [mockItem1(), mockItem2()]
    }
    
}
#endif
