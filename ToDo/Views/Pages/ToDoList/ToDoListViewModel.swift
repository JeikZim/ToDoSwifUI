//
//  ToDoListViewModel.swift
//  ToDo
//
//  Created by Руслан on 22.06.2023.
//

import Foundation

class ToDoListViewModel: ObservableObject {
    
    @Published private(set) var toDoItems: [ToDoItem] = []
    @Published var sortingMethod: SortingMethods = .alphabet
    @Published var sortingMode: SortingModes = .DESC
    
    init() {
        ToDoService.instance.$items.assign(to: &$toDoItems)
    }
    
}
