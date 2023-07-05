//
//  IconButton.swift
//  ToDo
//
//  Created by Руслан on 05.07.2023.
//

import SwiftUI

struct IconButton: View  {
    var imageName: String
    var isChosen: Bool
    var action: () -> Void
    
    var size: CGFloat
    var radius: CGFloat
    var baseColor: Color
    var color: Color {
        if isChosen {
            return baseColor.opacity(0.15)
        }
        return baseColor.opacity(0.05)
    }
    
    init(
        imageName: String,
        isChosen: Bool = true,
        action: @escaping () -> Void = {},
        size: CGFloat = 36,
        radius: CGFloat = 8,
        color: Color = .gray
    ) {
        self.imageName = imageName
        self.isChosen = isChosen
        self.action = action
        self.size = size
        self.radius = radius
        self.baseColor = color
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: radius)
                    .frame(width: size,height: size)
                    .foregroundColor(color)
                Image(systemName: imageName)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct IconButton_Previews: PreviewProvider {
    static var previews: some View {
        IconButton(imageName: "arrow.up")
    }
}
