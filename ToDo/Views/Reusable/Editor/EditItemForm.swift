//
//  EditItemForm.swift
//  ToDo
//
//  Created by Руслан on 23.06.2023.
//

import SwiftUI

struct EditItemForm: View {
    
    @Binding var content: String
    
    let saveButtonTitle: String
    let saveAction: () -> Void
    
    var body: some View {
        VStack {
            TextEditor(text: $content)
                .padding()
            
            Spacer()
            
            Button(action: saveAction, label: {
                Text(saveButtonTitle)
                    .font(.title3)
            })
            .disabled(content.isEmpty)
        }
    }
}

#if DEBUG
struct EditItemForm_Previews: PreviewProvider {
    
    @State
    static var content: String = ""
    
    static var previews: some View {
        EditItemForm(
            content: $content,
            saveButtonTitle: "Add note",
            saveAction: { }
        )
    }
}
#endif
