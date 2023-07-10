//
//  FavoriteButton.swift
//  ToDo
//
//  Created by Руслан on 05.07.2023.
//

import SwiftUI

struct FavoriteButton: View {
    
    let size: CGFloat = 32
    var fontSize: CGFloat = 24
    
//    @Binding
    var isFavorite: Bool
    var action: () -> Void// {
//        return {
//            isFavorite.toggle()
//        }
//    }
    
    var imageName: String {
        isFavorite ? "star.fill" : "star"
    }
    var color: Color {
        isFavorite ? .yellow : .gray.opacity(0.5)
    }
    
    var body: some View {
        Image(systemName: imageName)
            .font(.system(size: fontSize))
            .foregroundColor(color)
            .frame(width: size, height: size)
            .onTapGesture {
                action()
            }
        

    }
}

//struct FavoriteButton_Previews: PreviewProvider {
//    static var previews: some View {
//        FavoriteButton(isFavorite: false, action: {})
//            .padding(.all)
//    }
//}
