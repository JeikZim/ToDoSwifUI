//
//  ContentView.swift
//  ToDo
//
//  Created by Руслан on 21.06.2023.
//

import SwiftUI

struct ToDoItemsList<ToDoItemDestinationView: View>: View {

    let items: [ToDoItem]
    
    @Binding
    var selectedItem: ToDoItem?
    let itemDestination: (ToDoItem) -> ToDoItemDestinationView
    
    var body: some View {
        if items.isEmpty {
            Text("List is empty")
                .font(
                    .system(
                        size: 24,
                        weight: .bold //,
//                        design: .monospaced
                    )
                )
                .foregroundColor(.gray)
        } else {
            ScrollView {
                LazyVStack {
                    ForEach(items) { item in
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
            }
        }
    }
}

#if DEBUG
struct ToDoItemsList_Previews: PreviewProvider {
    @State
    static var selectedItem: ToDoItem? = .mockItem1()
    
    static var previews: some View {
        ToDoItemsList(
            items: ToDoItem.mockItems(),
            selectedItem: $selectedItem,
            itemDestination: { _ in EmptyView() }
        )
    }
}
#endif
