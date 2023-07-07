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
        VStack {
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
            .padding(.bottom, 0)
            
            
            if viewModel.toDoItemsPrejection.isEmpty {
                emptyTitle()
            } else {
                ScrollView {
                    toDoListView()
                }
            }
        }
        .onChange(of: viewModel.toDoItemsPrejection, perform: { _ in
            viewModel.sort()
            viewModel.filter()
        })
        .onChange(of: viewModel.sortingMethod, perform: sortingHandler)
        .onChange(of: viewModel.sortingMode, perform: sortingHandler)
        .onChange(of: viewModel.filters, perform: filteringHandler)
    }
    
    private func toDoListView() -> some View {
        LazyVStack {
            ForEach(viewModel.toDoItemsPrejection) { item in
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
        Button(action: { modalFiltersIsOpened.toggle() }, label: {
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
            action: { modalSortIsOpened.toggle() }
        )
    }
    
    private func filersButton() -> some View {
        IconButton(
            imageName: "flag",
            action: { modalFiltersIsOpened.toggle() }
        )
    }
    
    private func emptyTitle() -> some View {
        VStack {
            Spacer()
            Text("List is empty")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.gray)
            Spacer()
        }
        .offset(y: -60)
    }
    
    private func sortingHandler(_ eq: any Equatable)  {
        viewModel.sort()
    }
    
    private func filteringHandler(_ eq: any Equatable)  {
        viewModel.filter()
    }
}

//#if DEBUG
//struct ToDoItemsList_Previews: PreviewProvider {
//    @State
//    static var selectedItem: ToDoItem? = .mockItem1()
//    @State
//    static var modalSortIsOpened: Bool = false
//    @State
//    static var modalFiltersIsOpened: Bool = false
//
//    static var previews: some View {
//        ToDoItemsList(
//            modalSortIsOpened: $modalSortIsOpened,
//            modalFiltersIsOpened: $modalFiltersIsOpened,
//            selectedItem: $selectedItem,
//            viewModel: ToDoListViewModel(),
//            itemDestination: {_ in EmptyView()}
//        )
//    }
//}
//#endif
