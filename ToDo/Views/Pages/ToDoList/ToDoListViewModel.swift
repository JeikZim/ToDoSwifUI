//
//  ToDoListViewModel.swift
//  ToDo
//
//  Created by Руслан on 22.06.2023.
//

import Foundation

class ToDoListViewModel: ObservableObject {
    
    @Published private var toDoItems: [ToDoItem] = []
    @Published private(set) var toDoItemsPrejection: [ToDoItem] = []
    @Published var filters: Set<FilteringMethods> = []
    @Published var sortingMethod: SortingMethods = .none
    @Published var sortingMode: SortingModes = .none
    
    init() {
        ToDoService.instance.$items.assign(to: &$toDoItems)
        $toDoItems.assign(to: &$toDoItemsPrejection)
    }
    
    func filter() {
        toDoItemsPrejection = toDoItems
        
        if filters.isEmpty { return }
        
        if filters.contains(.favorite) {
            toDoItemsPrejection.removeAll(where: { !$0.isFavorite })
        }
        else {
            for toDoitem in toDoItems
            where toDoitem.isFavorite && !toDoItems.contains(toDoitem){
                toDoItemsPrejection.append(toDoitem)
            }
        }
        
        
        if filters.contains(.completed) {
            toDoItemsPrejection.removeAll(where: { !$0.isCompleted })
        }
        else {
            for toDoitem in toDoItems
            where toDoitem.isCompleted && !toDoItems.contains(toDoitem) {
                toDoItemsPrejection.append(toDoitem)
            }
        }
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
