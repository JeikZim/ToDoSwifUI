//
//  ContentView.swift
//  ToDo
//
//  Created by Руслан on 21.06.2023.
//

import SwiftUI
import Combine

struct ToDoItemsList<ToDoItemDestinationView: View>: View {
    
    @Binding var modalSortIsOpened: Bool
    @Binding var modalFiltersIsOpened: Bool
    @Binding var selectedItem: ToDoItem?
    
    var viewModel: ToDoListViewModel
        
    let itemDestination: (ToDoItem) -> ToDoItemDestinationView
    
    var body: some View {
        if viewModel.toDoItems.isEmpty {
            emptyTitle()
        } else {
            ScrollView {
                HStack(spacing: 14) {
                    filterTextButton()
                        .padding(.leading)
                    
                    filersButton()
                    
                    Spacer()
                    
                    sortTextButton()
                    
                    sortingChoiceButton()
                        .padding(.trailing)
                }
                .frame(height: 36)
                
                toDoListView()
            }
            .onChange(of: viewModel.toDoItems, perform: sortingHandler)
            .onChange(of: viewModel.sortingMethod, perform: sortingHandler)
            .onChange(of: viewModel.sortingMode, perform: sortingHandler)
        }
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
    
    private func filterTextButton() -> some View {
        Button(action: { modalSortIsOpened.toggle() }, label: {
            Text("Filters")
                .font(.system(size: 22, weight: .regular))
        })
        .buttonStyle(PlainButtonStyle())
    }
    
    private func sortTextButton() -> some View {
        Button(action: { modalSortIsOpened.toggle() }, label: {
            Text("Sort")
                .font(.system(size: 22, weight: .regular))
        })
        .buttonStyle(PlainButtonStyle())
    }
    
    private func sortingChoiceButton() -> some View {
        IconButton(
            imageName: viewModel.sortingMode.rawValue,
            action: { modalFiltersIsOpened.toggle() }
        )
    }
    
    private func filersButton() -> some View {
        IconButton(
            imageName: "flag",
            action: { modalFiltersIsOpened.toggle() }
        )
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
    static var modalSortIsOpened: Bool = false
    @State
    static var modalFiltersIsOpened: Bool = false

    static var previews: some View {
        ToDoItemsList(
            modalSortIsOpened: $modalSortIsOpened,
            modalFiltersIsOpened: $modalFiltersIsOpened,
            selectedItem: $selectedItem,
            viewModel: ToDoListViewModel(),
            itemDestination: {_ in EmptyView()}
        )
    }
}
#endif
