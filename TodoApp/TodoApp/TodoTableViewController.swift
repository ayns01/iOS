//
//  ViewController.swift
//  TodoApp
//
//  Created by 酒井綾菜 on 2019-05-02.
//  Copyright © 2019 Ayana Sakai. All rights reserved.
//

import UIKit
// delegate, datasource automatically conformed

class TodoTableViewController: UITableViewController{
    
    // MARK: - properties
    private var todos:[String] = [String]()
    
    // MARK: - Constants
    
    
    private let cellId = "todoCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(TodoTableViewCell.self, forCellReuseIdentifier: cellId)
            // editButtonItem comes with isEditing: Bool
        navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTodo))
        tableView.allowsMultipleSelectionDuringEditing = true
        
        //toolbar setup
        self.navigationController?.setToolbarHidden(false, animated: false)
        let flexible = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        let deleteButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.trash, target: self, action: #selector(didPressDelete))
        self.toolbarItems = [flexible, deleteButton]
        self.navigationController?.toolbar.barTintColor = UIColor.white
        
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
    }
    
    @objc func didPressDelete() {
        let selectedRows = self.tableView.indexPathsForSelectedRows
        if selectedRows != nil {
            for var selectionIndex in selectedRows! {
                while selectionIndex.item >= todos.count {
                    selectionIndex.item -= 1
                }
//                tableView(tableView, commit: .delete, forRowAt: selectionIndex)
                todos.remove(at: selectionIndex.row)
                tableView.deleteRows(at: [selectionIndex], with: .automatic)
            }
        }
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
        return todos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // For each cell ?
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! TodoTableViewCell
        
        cell.todoName.text = todos[indexPath.row]
        
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
            todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            print(".delete")
        default:
            break
        }
        
        // we need to tell the app to delete the rows we have chosen
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            todos.remove(at: indexPath.item)
            tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = todos[sourceIndexPath.row]
        todos.remove(at: sourceIndexPath.row)
        todos.insert(itemToMove, at: destinationIndexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let todo = todos[indexPath.row]// Unwrap
        let detailVC = DetailViewController()
        detailVC.todo = todo
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension TodoTableViewController: AddTodoViewControllerDelegate {
    func addTodoDidCancel() {
        
    }
    
    func addTodoDidFinish(_ todo: String) {
        todos.append(todo)
        tableView.reloadData() // Refresh!
    }
}

