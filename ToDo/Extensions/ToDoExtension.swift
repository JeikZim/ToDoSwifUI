//
//  RowExtension.swift
//  ToDo
//
//  Created by Руслан on 21.06.2023.
//

import Foundation

extension ToDoList {
    static var mockItem1: ToDoListItem { return ToDoListItem(content: "Small") }
    static var mockItem2: ToDoListItem { return ToDoListItem(content: "Lorem Ipsum") }
    static var mockItem3: ToDoListItem { return ToDoListItem(content: "Medium lorem ipsum and some text bla bla bla...") }
    static var mockItem4: ToDoListItem {
        return ToDoListItem(
            content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla maximus sit amet lorem in feugiat. Vestibulum rhoncus non velit pellentesque porttitor. Curabitur ipsum sem, eleifend vitae orci eget, mollis venenatis justo."
        )
    }
    static var mockList1: ToDoListService {
        ToDoListService.instance.items = [ToDoList.mockItem1, ToDoList.mockItem2, ToDoList.mockItem3, ToDoList.mockItem4]

        return ToDoListService.instance
    }
}

