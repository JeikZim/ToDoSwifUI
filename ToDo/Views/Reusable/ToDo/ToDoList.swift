//
//  ContentView.swift
//  ToDo
//
//  Created by Руслан on 21.06.2023.
//

import SwiftUI
import Combine

struct ToDoItemsList<ToDoItemDestinationView: View>: View {
    
    @Binding var modalIsOpened: Bool
    @Binding var selectedItem: ToDoItem?
    
    var viewModel: ToDoListViewModel
        
    let itemDestination: (ToDoItem) -> ToDoItemDestinationView
    
    var body: some View {
        if viewModel.toDoItems.isEmpty {
            emptyTitle()
        } else {
            ScrollView {
                HStack(spacing: 14) {
                    Spacer()
                    
                    sortButton()
                    
                    sortingChoiceButton()
                }
                .frame(height: 36)
                
                toDoListView()
            }
            .onChange(of: viewModel.toDoItems, perform: sortingHandler)
            .onChange(of: viewModel.sortingMethod, perform: sortingHandler)
            .onChange(of: viewModel.sortingMode, perform: sortingHandler)
        }
    }
    
    private func sortingChoiceButton() -> some View {
        IconButton(
            imageName: viewModel.sortingMode.rawValue,
            action: { modalIsOpened.toggle() }
        )
        .padding(.trailing)
    }
    
    
    private func toDoListView() -> some View {
        LazyVStack {
            ForEach(viewModel.toDoItems) { item in
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
    
    private func sortButton() -> some View {
        Button(action: { modalIsOpened.toggle() }, label: {
            Text("Sort")
                .font(.system(size: 24, weight: .regular))
        })
        .buttonStyle(PlainButtonStyle())
    }
    
    private func emptyTitle() -> some View {
        Text("List is empty")
            .font(.system(size: 24, weight: .bold))
            .foregroundColor(.gray)
    }
    
    private func sortingHandler(_ eq: any Equatable)  {
        viewModel.sort()
    }
}

#if DEBUG
struct ToDoItemsList_Previews: PreviewProvider {
    @State
    static var selectedItem: ToDoItem? = .mockItem1()
    @State
    static var modalIsOpened: Bool = true

    static var previews: some View {
        ToDoItemsList(
            modalIsOpened: $modalIsOpened,
            selectedItem: $selectedItem,
            viewModel: ToDoListViewModel(),
            itemDestination: {_ in EmptyView()}
        )
    }
}
#endif
