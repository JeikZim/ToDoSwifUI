//
//  EditorToDoItemPage.swift
//  ToDo
//
//  Created by Руслан on 22.06.2023.
//

import SwiftUI

struct EditToDoItemPage: View {
    
    var navigationTitle: String {
        viewModel.mode.isEditing ? "Note editing" : "New note"
    }
    
    @StateObject
    var viewModel: EditToDoItemViewModel
    
    // !!!
    init(mode: EditToDoItemMode, onEnded: @escaping () -> Void) {
        _viewModel = StateObject(wrappedValue: EditToDoItemViewModel(mode: mode, onEnded: onEnded))
    }
    
    var body: some View {
        let toolbarTextSize: CGFloat = 18
        
        EditItemForm(
            content: $viewModel.content,
            saveButtonTitle: viewModel.mode.isEditing ? "Edit" : "Add",
            saveAction: viewModel.saveContent
        )
        .navigationTitle(navigationTitle)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                HStack {
                    Image(systemName: "arrow.left")
                    Text("Back")
                        .font(.system(size: toolbarTextSize, weight: .medium))
                }
                .onTapGesture {
                    viewModel.saveStates()
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                if viewModel.mode.isEditing {
                    FavoriteButton(
                        fontSize: 18,
                        isFavorite: viewModel.isFavorite,
                        action: { viewModel.isFavorite.toggle() }
                    )
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                if viewModel.mode.isEditing {
                    CompleteCheckBox(
                        size: 24 ,fontSize: 14,
                        isSet: viewModel.isCompleted,
                        action: { viewModel.isCompleted.toggle() }
                    )
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                if viewModel.mode.isEditing {
                    Button("Delete", action: viewModel.delete)
                        .font(.system(size: toolbarTextSize, weight: .regular))
                        .foregroundColor(.red)
                }
            }
        }
    }
}

#if DEBUG
struct EditToDoItemPage_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EditToDoItemPage(mode: .create, onEnded: {  })
        }
    }
}
#endif
