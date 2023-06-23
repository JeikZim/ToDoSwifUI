//
//  ToDoList.swift
//  ToDo
//
//  Created by Руслан on 21.06.2023.
//

import Foundation

class ToDoService {
    
    @Published
    private(set) var items: [ToDoItem] = []
    
    private init() { }
    
    static let instance = ToDoService()
    
    
    func createItem(withContent content: String) {
        items.append(ToDoItem(content: content))
    }
    
    func updateItem(_ content: String, forItemWithId Id: String) {
        guard let index = items.firstIndex(where: { $0.id == Id }) else {
            return
        }
                
        items[index].content = content
    }
    
    func removeItem(byId id: String) {
        items.removeAll(where: { $0.id == id })
    }
}

