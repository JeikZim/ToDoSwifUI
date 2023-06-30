//
//  ToDoListPage.swift
//  ToDo
//
//  Created by Руслан on 22.06.2023.
//

import SwiftUI

struct ToDoListPage: View {
    
    @State
    var creationOpened: Bool = false
    @State
    var editingItem: ToDoItem?
    
    @StateObject
    var viewModel = ToDoListViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                ToDoItemsList(
                    items: viewModel.toDoItems,
                    selectedItem: $editingItem,
                    itemDestination: { item in
                        EditToDoItemPage(
                            mode: .edit(item: item),
                            onEnded: {editingItem = nil}
                        )
                    }
                )
                
                VStack {
                    Spacer()
                    
                    ZStack {
                        bottomLGradient()
                        
                        NavigationLink(
                            destination: EditToDoItemPage(
                                mode: .create,
                                onEnded: { creationOpened = false }),
                            isActive: $creationOpened,
                            label: addButtonLabel)
                    }
                    .offset(y: 40)
                }
            }
            .navigationTitle("To Do")
        }
    }
    
    private func addButtonLabel() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 100)
                .foregroundColor(.white.opacity(0.85))
                .frame(width: 148, height: 36)
            
            Text("Add new note")
                .font(.title3)
        }
        .offset(y: -8)
    }
    
    private func bottomLGradient() -> some View {
        LinearGradient(
            colors: [
                .white.opacity(0.0),
                .white.opacity(0.25),
                .white.opacity(0.75),
                .white.opacity(1.5)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
        .frame(height: 80)
    }
    
    
}

#if DEBUG
struct ToDoListPage_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListPage()
    }
}
#endif
