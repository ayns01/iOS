
//
//  Todo.swift
//  TodoApp
//
//  Created by 酒井綾菜 on 2019-05-21.
//  Copyright © 2019 Ayana Sakai. All rights reserved.
//

import Foundation

class TodoPrior {
    
    enum Priority: Int, CaseIterable {
        case high, medium, low
    }
    
    var todoTableVC: TodoTableViewController = TodoTableViewController()
    
//    private var highPriorityTodos: [TodoEntity] = []
//    private var mediumPriorityTodos: [TodoEntity] = []
//    private var lowPriorityTodos: [TodoEntity] = []
    
    init() {}
    
    func todoPrior(for priority: Priority) -> [TodoEntity] {
        switch priority {
        case .high:
            return todoTableVC.highTodos
        case .medium:
            return todoTableVC.midTodos
        case .low:
            return todoTableVC.lowTodos
        }
    }
    
    func addTodo(item: TodoEntity, for priority: Priority, at index: Int = -1) {
        switch priority {
        case .high:
            if index < 0 {
                todoTableVC.highTodos.append(item)
            } else {
                todoTableVC.highTodos.insert(item, at: index)
            }
        case .medium:
            if index < 0 {
                todoTableVC.midTodos.append(item)
            } else {
                todoTableVC.midTodos.insert(item, at: index)
            }
        case .low:
            if index < 0 {
                todoTableVC.lowTodos.append(item)
            } else {
                todoTableVC.lowTodos.insert(item, at: index)
            }
        }
    }
    
    func move(item: TodoEntity, from srcPriority: Priority, at srcPath: IndexPath, to destPriority: Priority, at destPath: IndexPath) {
        remove(item: item, from: srcPriority, at: srcPath.row)
        addTodo(item: item, for: destPriority, at: destPath.row)
    }
    
    func remove(item: TodoEntity, from priority: Priority, at index: Int) {
        switch priority {
        case .high:
            todoTableVC.highTodos.remove(at: index)
        case .medium:
            todoTableVC.midTodos.remove(at: index)
        case .low:
            todoTableVC.lowTodos.remove(at: index)
        }
    }
}
