//
//  AddTodoViewController.swift
//  TodoApp
//
//  Created by 酒井綾菜 on 2019-05-02.
//  Copyright © 2019 Ayana Sakai. All rights reserved.
//

import UIKit
import CoreData

protocol AddTodoViewControllerDelegate: class {
    func addTodoDidCancel()
    func addTodoDidFinish(_ todo: TodoEntity)
}

var todoPrior: String!

class AddTodoViewController: UIViewController {
    
    weak var delegate: AddTodoViewControllerDelegate?

    // Text field
    let todoTextField: UITextField = {
        let tf = UITextField(frame: .zero)
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Enter here..."
        return tf
    }()
    // Label
    let descriptionLabel: UILabel = UILabel(title: "What do you have to do?", color: .black, fontSize: 20, bold: true)
    // segmented control
    let segmentedControl: UISegmentedControl = {
        let items = ["high", "middle", "low"]
        let sc = UISegmentedControl(items : items)
        sc.selectedSegmentIndex = 0
        sc.layer.cornerRadius = 5.0
        sc.backgroundColor = UIColor.orange
        sc.tintColor = UIColor.yellow
        return sc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        navigationItem.title = "Add Todo"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didAddTodo))
        todoPrior = "high"
    }
    
    @objc fileprivate func didAddTodo() {
        // Delegate !!
        if let todoText = todoTextField.text { // Unwrap
            let managedContext = CoreDataManager.shared.persistentContainer.viewContext
            let newTodo = NSEntityDescription.insertNewObject(forEntityName: "TodoEntity", into: managedContext)
            newTodo.setValue(todoText , forKey: "todoItem")
            newTodo.setValue(1, forKey: "priority")
            CoreDataManager.shared.saveContext()
            
            delegate?.addTodoDidFinish(newTodo as! TodoEntity)
            navigationController?.popViewController(animated: true)
        }
        
        
    }
    
    fileprivate func setupUI() {
        let stackView = UIStackView(arrangedSubviews: [descriptionLabel, todoTextField])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 30
        view.addSubview(stackView)
        // Constraint
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 20).isActive = true
    }

}
