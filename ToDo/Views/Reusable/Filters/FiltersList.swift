//
//  FiltersList.swift
//  ToDo
//
//  Created by Руслан on 05.07.2023.
//

import SwiftUI

struct FiltersList: View {
    
    @Binding var chosenFilteringMethods: Set<FilteringMethods>
    
    var filteringItems: [FiltersItem] = [
        FiltersItem(filteringMethod: .completed),
        FiltersItem(filteringMethod: .favorite)
    ]
    
    var body: some View {
        let rowHeight: Int = 80
        
        ZStack {
            Color.white
            
            VStack {
                ForEach(filteringItems) { item in
                    FiltersRow(
                        title: item.title,
                        filteringMethod: item.filteringMethod,
                        chosenFilteringMethods: $chosenFilteringMethods
                    )
                    
                    Divider()
//                    if item.id != FiltersItem.count { Divider() }
                }
                
                resetRow(rowHeight: rowHeight)
            }
        }
        .cornerRadius(9)
        .frame(width: 260, height: CGFloat(filteringItems.count * rowHeight + rowHeight))
        .offset(y: -32)
    }
    
    private func resetRow(rowHeight: Int) -> some View {
        HStack {
            Button(action: {
                chosenFilteringMethods.removeAll()
            }, label: {
                ZStack {
                    Color.white
                    
                    Text("Reset")
                        .font(.title3)
                }
            })
        }
        .padding(.top, 0)
        .frame(height: CGFloat(rowHeight))
    }
}

struct FiltersItem: Identifiable, CountableID {
    static var count: Int = 0
    
    var id: Int = incrementCount()
    var title: String
    var filteringMethod: FilteringMethods
//    var title: String
    
    init(filteringMethod: FilteringMethods) {
        self.filteringMethod = filteringMethod
        self.title = filteringMethod.rawValue
    }
    
    internal static func incrementCount() -> Int {
        count += 1
        return count
    }
}

#if DEBUG
struct FiltersList_Previews: PreviewProvider {
    @State static var filteringMethods: Set<FilteringMethods> = [.favorite]
    
    static var previews: some View {
        FiltersList(chosenFilteringMethods: $filteringMethods)
    }
}
#endif
