//
//  ToDoItem.swift
//  ToDo
//
//  Created by Руслан on 21.06.2023.
//

import SwiftUI

struct ToDoItemRow: View {
    
    @ObservedObject
    var viewModel: ToDoItemViewModel
    
    init (item: ToDoItem) {
        self.viewModel = ToDoItemViewModel(item: item)
    }
    
    var body: some View {
        ZStack {
            if viewModel.item.isCompleted {
                rowBackground()
            } else {
                rowBackground()
                    .shadow(color: .black.opacity(0.15), radius: 4, x: 0,y: 2)
            }
            
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    if viewModel.item.isCompleted {
                        titleText(color: .black.opacity(0.25))
                        
                        subtitleText(color: .black.opacity(0.25))
                    } else {
                        titleText()
                        
                        subtitleText()
                    }
                }
                .padding()
                
                CheckBox(size: 32, isSet: $viewModel.item.isCompleted, action: viewModel.toggleCompletion)
            }
        }
        .fixedSize(horizontal: false, vertical: true)
    }
    
    private func rowBackground() -> some View {
        Color.white.cornerRadius(8)
    }
    
    private func titleText(color: Color = .black) -> some View {
        Text(viewModel.item.content)
            .foregroundColor(color)
            .frame(
                maxWidth: .greatestFiniteMagnitude,
                alignment: .leading
            )
    }
    
    private func subtitleText(color: Color = .gray) -> some View {
        Text(viewModel.item.date.toString())
            .foregroundColor(color)
            .font(.system(size: 14, weight: .medium))
    }
}

#if DEBUG
struct ToDoRow_Previews: PreviewProvider {
    static var previews: some View {
        ToDoItemRow(item: ToDoItem.mockItem1())
            .padding()
    }
}
#endif
