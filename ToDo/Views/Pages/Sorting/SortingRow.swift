//
//  SortingRow.swift
//  ToDo
//
//  Created by Руслан on 04.07.2023.
//

import SwiftUI

struct SortingRow: View {
    
    var title: String
    var hasModes: Bool
    var sortingMethod: SortingMethods
    
    @Binding var chosenSortingMethod: SortingMethods
    @Binding var chosenSortingMode: SortingModes
    
    var modeIsChosen: Bool {
        if case sortingMethod = chosenSortingMethod {
            return true
        }
        return false
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            Color.white
            
            HStack {
                Text(title)
                    .font(.title3)
                    .padding(.leading)
                
                Spacer()
                
                if hasModes {
                    HStack {
                        directionButton(
                            "arrow.up",
                            isChosen: modeIsChosen && chosenSortingMode == .ASC,
                            action: {
                                chosenSortingMethod = sortingMethod
                                chosenSortingMode = .ASC
                            }
                        )
                        directionButton(
                            "arrow.down",
                            isChosen: modeIsChosen && chosenSortingMode == .DESC,
                            action: {
                                chosenSortingMethod = sortingMethod
                                chosenSortingMode = .DESC
                            }
                        )
                    }
                    .padding(.trailing)
                }
                else {
                    directionButton(
                        "circle",
                        isChosen: modeIsChosen,
                        action: {
                            chosenSortingMethod = sortingMethod
                            chosenSortingMode = .none
                        }
                    )
                    .padding(.trailing)
                }
            }
        }
        .frame(height: 80)
    }
    
    private func directionButton(
        _ imageName: String,
        isChosen: Bool,
        action: @escaping () -> Void
    ) -> some View {
        let size: CGFloat = 36
        let radius: CGFloat = 8
        var color: Color {
            if isChosen {
                return .gray.opacity(0.15)
            }
            return .gray.opacity(0.05)
        }
        
        return Button {
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

struct SortingRow_Previews: PreviewProvider {
    @State
    static var chosenSortingMethod: SortingMethods = .none
    
    @State
    static var chosenSortingMode: SortingModes = .none
    
    static var previews: some View {
        SortingRow(title: "Basic", hasModes: false, sortingMethod: .none, chosenSortingMethod: $chosenSortingMethod, chosenSortingMode: $chosenSortingMode)
    }
}
