//
//  ToDoList.swift
//  ToDo
//
//  Created by Руслан on 21.06.2023.
//

import Foundation

class ToDoService {
    
    @Published
    private(set) var items: [ToDoItem] = [
        ToDoItem(content: "Aome words"),
        ToDoItem(content: "Bome words"),
        ToDoItem(content: "Come words"),
        ToDoItem(content: "Dome words"),
        ToDoItem(content: "Eome words"),
        ToDoItem(content: "Fome words"),
        ToDoItem(content: "Gome words"),
        ToDoItem(content: "Some words 123"),
        ToDoItem(content: "Some words wedwfewg"),
        ToDoItem(content: "Some words sdvvxcvxcv"),
        ToDoItem(content: "Some words"),
        ToDoItem(content: "Some wordss sd sdfsdf"),
        ToDoItem(content: "Some wordsrgr"),
        ToDoItem(content: "Some wordssdvseweg"),
        ToDoItem(content: "Some words"),
        ToDoItem(content: "Some words sdfsdf"),
        ToDoItem(content: "Some wordswefwe"),
        ToDoItem(content: "Some words")
    ]
    
    private init() { }
    static let instance = ToDoService()
    
    func createItem(withContent content: String) {
        items.append(ToDoItem(content: content))
    }
    
    func updateItem(_ content: String, forItemWithId id: String) {
        updateItemField(byItemId: id) { index in
            items[index].content = content
        }
    }
    
    func setFavorites(byItemId id: String, newState isFavorite: Bool) {
        updateItemField(byItemId: id) { index in
            items[index].isFavorite = isFavorite
        }
    }
    
    func setCompletion(byItemId id: String, newState isCompleted: Bool) {
        updateItemField(byItemId: id) { index in
            items[index].isCompleted = isCompleted
        }
    }
    
    func toggleFavorite(byItemId id: String) {
        updateItemField(byItemId: id) { index in
            items[index].isFavorite.toggle()
        }
    }
    
    func toggleCompletion(byItemId id: String) {
        updateItemField(byItemId: id) { index in
            items[index].isCompleted.toggle()
        }
    }
    
    func removeItem(byId id: String) {
        items.removeAll(where: { $0.id == id })
    }
    
    private func updateItemField(byItemId id: String, action: (Int) -> Void) {
        guard let index = items.firstIndex(where: { $0.id == id })
        else {
            return
        }
                
        action(index)
    }
}

