//
//  ViewController.swift
//  TodoApp
//
//  Created by 酒井綾菜 on 2019-05-02.
//  Copyright © 2019 Ayana Sakai. All rights reserved.
//

import UIKit
import CoreData

class TodoTableViewController: UITableViewController{
    // MARK: - properties
    var highTodos = [TodoEntity]()
    var midTodos = [TodoEntity]()
    var lowTodos = [TodoEntity]()
    
    // MARK: - Constants
    
    private let cellId = "todoCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(TodoTableViewCell.self, forCellReuseIdentifier: cellId)
        navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTodo))
        tableView.allowsMultipleSelectionDuringEditing = true
        
        //toolbar setup
        self.navigationController?.setToolbarHidden(false, animated: false)
        let flexible = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        let deleteButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.trash, target: self, action: #selector(didPressDelete))
        self.toolbarItems = [flexible, deleteButton]
        self.navigationController?.toolbar.barTintColor = UIColor.white
        
        fetchCompanies()
        
    }
    
    @objc func didPressDelete() {
        let selectedRows = self.tableView.indexPathsForSelectedRows
        
        if selectedRows != nil {
            for var selectionIndex in selectedRows! {
                let managedContext = CoreDataManager.shared.persistentContainer.viewContext
                
                tableView(tableView, commit: .delete, forRowAt: selectionIndex)
                
                let priorityIndex = selectionIndex.section
                
                switch priorityIndex {
                case 0:
                    let item = self.highTodos[selectionIndex.row]
                    managedContext.delete(item)
                    self.highTodos.remove(at: selectionIndex.row)
                case 1:
                    let item = self.midTodos[selectionIndex.row]
                    managedContext.delete(item)
                    self.midTodos.remove(at: selectionIndex.row)
                case 2:
                    let item = self.lowTodos[selectionIndex.row]
                    managedContext.delete(item)
                    self.lowTodos.remove(at: selectionIndex.row)
                default:
                    return
                }
                
                self.tableView.deleteRows(at: [selectionIndex], with: .automatic)
                CoreDataManager.shared.saveContext()
            }
        }
    }
    
    private func fetchCompanies() {
        
        let managedContext = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<TodoEntity>(entityName: "TodoEntity")
        do {
            let companies = try managedContext.fetch(fetchRequest)
            
            for todo in companies {
                if todo.priority == 0 {
                    highTodos.append(todo)
                } else if todo.priority == 1 {
                    midTodos.append(todo)
                } else if todo.priority == 2 {
                    lowTodos.append(todo)
                }
            }
            
            print("Total TodoItem is" + String(companies.count))
            
            self.tableView.reloadData()
            
        }catch let err {
            print("Failed to fetch companies: \(err)")
        }
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
    }
    
    private func priorityForSectionIndex(_ index: Int) -> TodoPrior.Priority? {
        return TodoPrior.Priority(rawValue: index)
    }
    
    @objc func addTodo() {
        // go to add page view
        let addTodoVC = AddTodoViewController()
        addTodoVC.delegate = self
        navigationController?.pushViewController(addTodoVC, animated: true)
    }
    
    // MARK: tableView datasource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // How many cells ?
        switch section {
        case 0:
            return highTodos.count
        case 1:
            return midTodos.count
        case 2:
            return lowTodos.count
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // For each cell
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TodoTableViewCell

        let priorityIndex = indexPath.section
        
        if priorityIndex == 0 {
            let item = highTodos[indexPath.row]
            cell.todoName.text = item.todoItem
        }
        if priorityIndex == 1 {
            let item = midTodos[indexPath.row]
            cell.todoName.text = item.todoItem
        }
        if priorityIndex == 2 {
            let item = lowTodos[indexPath.row]
            cell.todoName.text = item.todoItem
        }
        
        cell.accessoryType = .detailDisclosureButton
        
        return cell
    }
}

 // MARK: -TableView Delegate
extension TodoTableViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .insert:
            print(".insert")
        case .delete:
            print(".delete")
        default:
            break
        }
        
        // we need to tell the app to delete the rows we have chosen
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let priorityIndex = sourceIndexPath.section
        let newPriorityIndex = destinationIndexPath.section
        
        
        var item: TodoEntity?
        
        switch priorityIndex {
        case 0:
            item = highTodos[sourceIndexPath.row]
            highTodos.remove(at: sourceIndexPath.row)
        case 1:
            item = midTodos[sourceIndexPath.row]
            midTodos.remove(at: sourceIndexPath.row)
        case 2:
            item = lowTodos[sourceIndexPath.row]
            lowTodos.remove(at: sourceIndexPath.row)
        default:
            return
        }
        
        switch newPriorityIndex {
        case 0:
            highTodos.append(item!)
            item!.priority = 0
        case 1:
            midTodos.append(item!)
            item!.priority = 1
        case 2:
            lowTodos.append(item!)
            item!.priority = 2
        default:
            return
        }
        
        CoreDataManager.shared.saveContext()
        
        tableView.reloadData()
        
    }
    
//    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
//        let todoTitle = allItem[indexPath.row].title
//        let todoPrior = allItem[indexPath.row].priority
//        let detailVC = DetailViewController()
//        detailVC.todoTitle = todoTitle
//        detailVC.todoPriority = todoPrior
//        navigationController?.pushViewController(detailVC, animated: true)
//    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        // delete action
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") {
            (action, indexPath) in
            // remove from the tableView
            let managedContext = CoreDataManager.shared.persistentContainer.viewContext
            
            let priorityIndex = indexPath.section
            
            if priorityIndex == 0 {
                let item = self.highTodos[indexPath.row]
                managedContext.delete(item)
                self.highTodos.remove(at: indexPath.row)
            }
            if priorityIndex == 1 {
                let item = self.midTodos[indexPath.row]
                managedContext.delete(item)
                self.midTodos.remove(at: indexPath.row)
            }
            if priorityIndex == 2 {
                let item = self.lowTodos[indexPath.row]
                managedContext.delete(item)
                self.lowTodos.remove(at: indexPath.row)
            }
            
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            CoreDataManager.shared.saveContext()
            
        }
        
//        // edit action
//        let editAction = UITableViewRowAction(style: .normal, title: "Edit") {
//            (action, indexPath) in
//
//            // 1. navigate to AddCompanyViewController
//            let editVC = AddCompanyViewController()
//            editVC.delegate = self
//            editVC.company = self.companies[indexPath.row]
//            let editNVC = LightStatusBarNavigationController(rootViewController: editVC)
//
//            self.present(editNVC, animated: true, completion: nil)
//
//        }
//        return [deleteAction, editAction]
        return [deleteAction]
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title: String? = nil
        switch section {
        case 0:
            title = "High Priority"
        case 1:
            title = "Medium Priority"
        case 2:
            title = "Low Priority"
        default:
            return "None"
        }
        return title
    }
}

extension TodoTableViewController: AddTodoViewControllerDelegate {
    func addTodoDidCancel() {
        
    }
    
    func addTodoDidFinish(_ todo: TodoEntity) {
        midTodos.append(todo)
        tableView.reloadData()
    }
}

