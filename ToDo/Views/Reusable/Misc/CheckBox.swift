//
//  CheckBox.swift
//  ToDo
//
//  Created by Руслан on 30.06.2023.
//

import SwiftUI

struct CheckBox: View {
    var size: CGFloat
    
    @Binding
    var isSet: Bool
    var action: () -> Void
    
    var body: some View {
        let strokeColor: Color = .black.opacity(0.25)
//        Color(
//            red: 0,
//            green: 0,
//            blue: 0,
//            opacity: 0.35
//        )
        
        Button(action: action, label: {
            ZStack {
                RoundedRectangle(cornerRadius: 4)
                    .strokeBorder(strokeColor, lineWidth: 1)
                    .foregroundColor(.white)
                    .frame(width: size, height: size)
                
                Image(systemName: isSet ? "checkmark" : "checkmark")
                    .foregroundColor(isSet ? .green : .white)
                    .padding(.all, 24)
            }
        })
    }
}

#if DEBUG
struct CheckBox_Previews: PreviewProvider {
    @State
    static var isSet: Bool = false
    
    static var previews: some View {
        CheckBox(size: 32, isSet: $isSet, action: {  })
    }
}
#endif
