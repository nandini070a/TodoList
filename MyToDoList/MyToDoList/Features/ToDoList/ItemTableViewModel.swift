//
//  ItemTableViewModel.swift
//  MyToDoList
//
//  Created by Nandini Saha on 2022-02-09.
//

import UIKit

class ItemTableViewModel {
    
    private let defaults = UserDefaults.standard
    var todolist = [ToDoItem]()
    
    func addItem(_ title: String) {
        todolist.append(ToDoItem(title))
    }
    
    func toggleDone(_ row: Int) {
        todolist[row].done = !todolist[row].done
    }
    
    func deleteRow(_ row: Int) {
        todolist.remove(at: row)
    }
    
    func returnToDoRow(_ row: Int) -> ToDoItem {
        return todolist[row]
    }
    
    func numberOfRows() -> Int {
        return todolist.count
    }
    
    func saveData() {
        var encodedList = [[String: Any]]()
        for item in todolist {
            encodedList.append(item.toPropertylist())
        }
        defaults.set(encodedList, forKey: "encodedList")
    }
    
    func fetchData() {
        if let list = defaults.value(forKey: "encodedList") as? [[String: Any]] {
            for item in list {
                if let todoItem = ToDoItem(item) {
                    todolist.append(todoItem)
                }
            }
        }
    }
}


