//
//  ToDoListViewModel.swift
//  ToDo
//
//  Created by Руслан on 22.06.2023.
//

import Foundation

class ToDoListViewModel: ObservableObject {
    
    @Published private(set) var toDoItems: [ToDoItem] = []
    @Published var sortingMethod: SortingMethods = .none
    @Published var sortingMode: SortingModes = .none
    
    init() {
        ToDoService.instance.$items.assign(to: &$toDoItems)
    }
    
    func sort() {
        switch sortingMethod {
        case .date:
            switch sortingMode {
            case .ASC:
                toDoItems.sort(by: { $0.date < $1.date })
                
            case .DESC:
                toDoItems.sort(by: { $0.date > $1.date })
                
            case .none:
                toDoItems.sort(by: { $0.date > $1.date })
            }
        case .alphabet:
            switch sortingMode {
            case .ASC:
                toDoItems.sort(by: { $0.content < $1.content })
                
            case .DESC:
                toDoItems.sort(by: { $0.content > $1.content })
                
            case .none:
                toDoItems.sort(by: { $0.content > $1.content })
            }
        case .none:
            toDoItems.sort(by: { $0.date < $1.date })
        }
    }
}
