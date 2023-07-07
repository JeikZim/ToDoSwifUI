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
                        IconButton(
                            imageName: SortingModes.ASC.rawValue,
                            isChosen: modeIsChosen && chosenSortingMode == .ASC,
                            action: {
                                chosenSortingMethod = sortingMethod
                                chosenSortingMode = .ASC
                            }
                        )
                        IconButton(
                            imageName: SortingModes.DESC.rawValue,
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
                    IconButton(
                        imageName: SortingModes.none.rawValue,
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
}

#if DEBUG
struct SortingRow_Previews: PreviewProvider {
    @State
    static var chosenSortingMethod: SortingMethods = .none
    
    @State
    static var chosenSortingMode: SortingModes = .none
    
    static var previews: some View {
        SortingRow(title: "Basic", hasModes: false, sortingMethod: .none, chosenSortingMethod: $chosenSortingMethod, chosenSortingMode: $chosenSortingMode)
    }
}
#endif
