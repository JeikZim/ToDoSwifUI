//
//  CompleteCheckBox.swift
//  ToDo
//
//  Created by Руслан on 30.06.2023.
//

import SwiftUI

struct CompleteCheckBox: View {
    var size: CGFloat = 26
    var fontSize: CGFloat = 20
    
    var isSet: Bool
    var action: () -> Void
    
    var imageName: String = "checkmark"
    
    var body: some View {
        let strokeColor: Color = .black.opacity(0.25)
        let primaryColor: Color = .white
//        let strokeColorSet: Color = .black.opacity(0.175)
//        let strokeColorUnset: Color = .black.opacity(0.25)
        
//        Button(action: action, label: {
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
                
                Image(systemName: imageName)
                    .foregroundColor(isSet ? .green : primaryColor.opacity(0))
                    .font(.system(size: fontSize))
                    .padding(.all, 24)
            }
            .onTapGesture {
                action()
            }
//        })
//        .buttonStyle(PlainButtonStyle())
    }
}

#if DEBUG
struct CompleteCheckBox_Previews: PreviewProvider {
    @State
    static var isSet: Bool = false
    
    static var previews: some View {
        CompleteCheckBox(size: 32, isSet: isSet, action: {  })
    }
}
#endif
