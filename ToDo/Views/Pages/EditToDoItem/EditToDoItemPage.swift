//
//  EditorToDoItemPage.swift
//  ToDo
//
//  Created by Руслан on 22.06.2023.
//

import SwiftUI

struct EditToDoItemPage: View {
    
    @StateObject
    var viewModel: EditToDoItemViewModel
    
    // !!!
    init(mode: EditToDoItemMode, onEnded: @escaping () -> Void) {
        _viewModel = StateObject(wrappedValue: EditToDoItemViewModel(mode: mode, onEnded: onEnded))
    }
    
    var body: some View {
        EditItemForm(
            content: $viewModel.content, saveButtonTitle: viewModel.mode.isEditing ? "Edit" : "Add", saveAction: viewModel.save
        )
        .navigationTitle(viewModel.mode.isEditing ? "Note editing" : "New note")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if viewModel.mode.isEditing {
                    Button("Delete", action: viewModel.delete)
                        .font(.system(size: 16.5, weight: .regular))
                        .foregroundColor(.red)
                    
                }
            }
        }
        
        
        
//            VStack{
//                TextEditor(text: $viewModel.content)
//                    .onAppear {
//                        viewModel.updateData(mode)
//                    }
//                switch editorMode {
//                case .creating:
//                    Button("Add") {
//                        todoList.createItem(content: viewModel.content)
//                        presentationMode.wrappedValue.dismiss()
//                     }
//                    .disabled(viewModel.content == "")
//                    .navigationTitle("Create ToDo")
//                case .editinig(let item):
//                    Button("Edit") {
//                        todoList.updateItem(byId: item.id, content: viewModel.content)
//                        presentationMode.wrappedValue.dismiss()
//                     }
//                    .disabled(viewModel.content == "")
//                    .navigationTitle("Edit ToDo")
//                }
//
//            }
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
