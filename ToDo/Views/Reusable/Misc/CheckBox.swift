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
        let primaryColor: Color = .white
//        let strokeColorSet: Color = .black.opacity(0.175)
//        let strokeColorUnset: Color = .black.opacity(0.25)
            
        
//        Color(
//            red: 0,
//            green: 0,
//            blue: 0,
//            opacity: 0.35
//        )
        
        Button(action: action, label: {
            ZStack {
                primaryColor
                    .frame(width: size, height: size)
                RoundedRectangle(cornerRadius: 4)
                    .strokeBorder(
                        strokeColor,
//                        isSet ? strokeColorSet : strokeColorUnset,
                        lineWidth: 1)
                    .frame(width: size, height: size)
                    .foregroundColor(primaryColor)
                
                Image(systemName: isSet ? "checkmark" : "checkmark")
                    .foregroundColor(isSet ? .green : primaryColor)
                    .padding(.all, 24)
            }
        })
        .buttonStyle(PlainButtonStyle())
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
