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
    @State
    var modalIsOpened: Bool = false
    
    @StateObject
    var viewModel = ToDoListViewModel()
    
    var body: some View {
        NavigationView {
                ZStack {
                ToDoItemsList(
                    modalIsOpened: $modalIsOpened,
                    selectedItem: $editingItem,
                    sortingMethod: $viewModel.sortingMethod,
                    sortingModes: $viewModel.sortingMode,
                    itemDestination: { item in
                        EditToDoItemPage(
                            mode: .edit(item: item),
                            onEnded: {editingItem = nil}
                        )
                    },
                    items: viewModel.toDoItems
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
                    
                if modalIsOpened {
                    ZStack {
                        Button(action: {
                            modalIsOpened = false
                        }, label: {
                            Color.gray
                                .opacity(0.2)
                                .ignoresSafeArea(.all)
                        })
                        .buttonStyle(.plain)
                        
                        SortingList(
                            chosenSortingMethod: $viewModel.sortingMethod,
                            chosenSortingMode: $viewModel.sortingMode
                        )
                        
                    }
                }
            }
            .navigationTitle("To Do")
        }
    }
    
    private func addButtonLabel() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 100)
                .foregroundColor(.white.opacity(0.25))
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
//
//struct SortingMode {
//    let title: String
//    let method: SortingMethods
//    
//    init (_ title: String, sortingMethod: SortingMethods) {
//        self.title = title
//        self.method = sortingMethod
//    }
//}

#if DEBUG
struct ToDoListPage_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListPage()
    }
}
#endif
