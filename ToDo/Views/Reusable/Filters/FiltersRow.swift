//
//  FiltersRow.swift
//  ToDo
//
//  Created by Руслан on 05.07.2023.
//

import SwiftUI

struct FiltersRow: View {
    
    var title: String
    var filteringMethod: FilteringMethods
    
    @Binding var chosenFilteringMethods: Set<FilteringMethods>
    
    var methodIsChosen: Bool {
        if chosenFilteringMethods.contains(filteringMethod) {
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
                
                CompleteCheckBox(isSet: methodIsChosen, action: {
                    if methodIsChosen {
                        chosenFilteringMethods
                            .remove(filteringMethod)
                    } else {
                        chosenFilteringMethods
                            .insert(filteringMethod)
                    }
                })
                    .padding(.trailing)
            }
        }
        .frame(height: 80)
    }
}


#if DEBUG
struct FiltersRow_Previews: PreviewProvider {
    @State
    static var chosenFilteringMethods: Set<FilteringMethods> = []
    
    static var previews: some View {
        FiltersRow(title: "Basic", filteringMethod: .favorite, chosenFilteringMethods: $chosenFilteringMethods)
    }
}
#endif
