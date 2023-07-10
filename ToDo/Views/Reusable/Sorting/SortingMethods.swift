//
//  SortingMethods.swift
//  ToDo
//
//  Created by Руслан on 03.07.2023.
//

import Foundation

enum SortingMethods: String, Equatable {
    case alphabet = "Alphabetically"
    case date = "By date"
    case creationDate = "By creation"
    case none = "Basic"
    
}

enum SortingModes: String, Equatable {
    case ASC = "arrow.up"
    case DESC = "arrow.down"
    case none = "arrow.up.arrow.down"
}
