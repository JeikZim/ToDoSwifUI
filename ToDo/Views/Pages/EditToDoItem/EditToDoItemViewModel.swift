//
//  EditorToDoItemViewModel.swift
//  ToDo
//
//  Created by Руслан on 22.06.2023.
//

import Foundation

class EditToDoItemViewModel: ObservableObject {
    
    let mode: EditToDoItemMode
    let onEnded: () -> Void
    
    @Published var content: String = ""
    @Published var isFavorite: Bool = false
    @Published var isCompleted: Bool = false
    
    init(mode: EditToDoItemMode, onEnded: @escaping () -> Void) {
        self.mode = mode
        self.onEnded = onEnded
        
        if case .edit(let item) = mode {
            isCompleted = item.isCompleted
            isFavorite = item.isFavorite
            content = item.content
        }
    }
    
    func saveStates() {
        switch mode {
        case .create:
            onEnded()
            return
            
        case .edit(let item):
            ToDoService.instance.setFavorites(byItemId: item.id, newState: isFavorite)
            
            ToDoService.instance.setCompletion(byItemId: item.id, newState: isCompleted)
                        
        }
        onEnded()
    }
    
    func saveContent() -> Void {
        switch mode {
        case .create:
            ToDoService.instance.createItem(withContent: content)
            
        case .edit(let item):
            ToDoService.instance.updateItem(content, forItemWithId: item.id)
            
            ToDoService.instance.setFavorites(byItemId: item.id, newState: isFavorite)
            
            ToDoService.instance.setCompletion(byItemId: item.id, newState: isCompleted)
        }
        
        onEnded()
    }
    
    func delete() -> Void {
        //!
        guard case let .edit(item) = mode else {
            return
        }
        
        ToDoService.instance.removeItem(byId: item.id)
        
        onEnded()
    }
}















/*
 
    init(editorMode: EditorToDoListMode? = nil) {
        if let editorMode = editorMode {
            self.editorMode = editorMode
        }
        else {
            self.editorMode = .creating
        }

        switch editorMode {
        case .creating:
            self.content = ""
        case .editinig(let item):
            self.content = item.content
        case .none:
            self.content = ""
        }
    }

    func updateData(_ editorMode: EditorToDoListMode) -> Void {
        self.editorMode = editorMode

        switch editorMode {
        case .editinig(let item):
            self.content = item.content
        case .creating:
            self.content = content
        }
    }
}
 
 */
