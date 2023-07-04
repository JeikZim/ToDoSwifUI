//
//  SortingList.swift
//  ToDo
//
//  Created by Руслан on 03.07.2023.
//

import SwiftUI

struct SortingList: View {
    
    @Binding var chosenSortingMethod: SortingMethods
    @Binding var chosenSortingMode: SortingModes
    
    var sortingItems: [SortingItem] = [
        SortingItem(title: "Alphabet", hasModes: true, sortingMethod: .alphabet),
        SortingItem(title: "By date", hasModes: true, sortingMethod: .date),
        SortingItem(title: "Basic", hasModes: false, sortingMethod: .none)
    ]
    
    var body: some View {
        ZStack {
            Color.white
            
            VStack {
                ForEach(sortingItems) { item in
                    SortingRow(
                        title: item.title,
                        hasModes: item.hasModes,
                        sortingMethod: item.sortingMethod,
                        chosenSortingMethod: $chosenSortingMethod,
                        chosenSortingMode: $chosenSortingMode
                    )
                    Divider()
                }
            }
        }
        .cornerRadius(9)
        .frame(width: 240, height: 240)
        .offset(y: -32)
    }
}


struct SortingItem: Identifiable {
    static var count: Int = 0
    
    var id: Int = incrementCount()
    var title: String
    var hasModes: Bool
    var sortingMethod: SortingMethods
    
    private static func incrementCount() -> Int {
        count += 1
        return count
    }
}

#if DEBUG
struct SortingList_Previews: PreviewProvider {
//    @State
//    static var isChosed: Bool = false
    
    @State static var sortingMethod: SortingMethods = .none
    @State static var sortingMode: SortingModes = .none

    static var previews: some View {
        SortingList(chosenSortingMethod: $sortingMethod, chosenSortingMode: $sortingMode)
    }
}
#endif
