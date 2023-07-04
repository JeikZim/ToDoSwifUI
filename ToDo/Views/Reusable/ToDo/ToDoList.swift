//
//  ContentView.swift
//  ToDo
//
//  Created by Руслан on 21.06.2023.
//

import SwiftUI

struct ToDoItemsList<ToDoItemDestinationView: View>: View {
    
    @Binding var modalIsOpened: Bool
    @Binding var selectedItem: ToDoItem?
    
    @Binding var sortingMethod: SortingMethods
    @Binding var sortingModes: SortingModes
    
    let itemDestination: (ToDoItem) -> ToDoItemDestinationView
    let items: [ToDoItem]
    
    @State var itemsProjections: [ToDoItem] = []
    
    var body: some View {
        if items.isEmpty {
            emptyTitle()
        } else {
            ScrollView {
                HStack(alignment: .top) {
                    Spacer()
                    
                    sortButton()
                }
                .frame(height: 18)
                
                toDoListView()
            }
        }
    }
    
    private func toDoListView() -> some View {
        LazyVStack {
            ForEach(itemsProjections) { item in
                NavigationLink(
                    destination: itemDestination(item),
                    tag: item,
                    selection: $selectedItem,
                    label: { ToDoItemRow(item: item) }
                )
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding()
        .onAppear {
            itemsProjections = items
            
            switch sortingMethod {
            case .date:
                switch sortingModes {
                case .ASC:
                    itemsProjections.sort(by: { $0.date < $1.date })
                    
                case .DESC:
                    itemsProjections.sort(by: { $0.date > $1.date })
                    
                case .none:
                    itemsProjections.sort(by: { $0.date > $1.date })
                }
            case .alphabet:
                switch sortingModes {
                case .ASC:
                    itemsProjections.sort(by: { $0.content < $1.content })
                    
                case .DESC:
                    itemsProjections.sort(by: { $0.content > $1.content })
                    
                case .none:
                    itemsProjections.sort(by: { $0.content > $1.content })
                }
            case .none:
                return
            }
        }
    }
    
    private func sortButton() -> some View {
        Button(action: {
            modalIsOpened = true
        }, label: {
            Text("Sort")
                .font(.system(size: 20, weight: .medium))
        })
        .padding(.trailing, 30)
        .buttonStyle(PlainButtonStyle())
    }
    
    private func emptyTitle() -> some View {
        Text("List is empty")
            .font(.system(size: 24, weight: .bold))
            .foregroundColor(.gray)
    }
}

#if DEBUG
struct ToDoItemsList_Previews: PreviewProvider {
    @State
    static var selectedItem: ToDoItem? = .mockItem1()
    @State
    static var modalIsOpened: Bool = true
    @State
    static var sortingMethod: SortingMethods = .alphabet
    @State
    static var sortingMode: SortingModes = .DESC
    
    
    static var previews: some View {
        ToDoItemsList(
            modalIsOpened: $modalIsOpened,
            selectedItem: $selectedItem,
            sortingMethod: $sortingMethod,
            sortingModes: $sortingMode,
            itemDestination: {_ in EmptyView()},
            items: ToDoService.instance.items
        )
    }
}
#endif
