//
//  ToDoItemViewModel.swift
//  ToDo
//
//  Created by Руслан on 30.06.2023.
//

import Foundation

class ToDoItemViewModel: ObservableObject {
    @Published
    var item: ToDoItem
    
    var toggleCompletion: () -> Void
    var toggleFavorite: () -> Void
    
    init(item: ToDoItem) {
        self.item = item
        
        toggleCompletion = {
//            ToDoService.instance.toggleCompletion(byItemId: item.id)
        }
        
        toggleFavorite = {
//            ToDoService.instance.toggleFavorite(byItemId: item.id)
        }
    }
}
