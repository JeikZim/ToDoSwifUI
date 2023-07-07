//
//  CountableID.swift
//  ToDo
//
//  Created by Руслан on 07.07.2023.
//

import Foundation

protocol CountableID {
    static var count: Int { get }
    
    var id: Int { get }
    
    static func incrementCount() -> Int 
}
