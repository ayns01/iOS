//
//  AddTodoViewController.swift
//  TodoApp
//
//  Created by 酒井綾菜 on 2019-05-02.
//  Copyright © 2019 Ayana Sakai. All rights reserved.
//

import UIKit

protocol AddTodoViewControllerDelegate: class {
    func addTodoDidCancel()
    func addTodoDidFinish(_ todo: String)
}

class AddTodoViewController: UIViewController {
    
    weak var delegate: AddTodoViewControllerDelegate?

    // To prepare...
    
    // Text field
    let todoTextField: UITextField = {
        let tf = UITextField(frame: .zero)
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Enter here..."
        return tf
    }()
    // Label
    let descriptionLabel: UILabel = UILabel(title: "What do you have to do?😻", color: .black, fontSize: 20, bold: true)
    // segmented control
    let segmentedControl: UISegmentedControl = {
        let items = ["high", "middle", "low"]
        let sc = UISegmentedControl(items : items)
        sc.selectedSegmentIndex = 0
        sc.layer.cornerRadius = 5.0
        sc.backgroundColor = UIColor.orange
        sc.tintColor = UIColor.yellow
        sc.addTarget(self, action: #selector(segmentIndexChanged(_:)), for: .valueChanged)
        return sc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        navigationItem.title = "Add Todo"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didAddTodo))
        
    }
    
    @objc fileprivate func didAddTodo() {
        // Delegate !!
        if let todo = todoTextField.text { // Unwrap
            delegate?.addTodoDidFinish(todo)
            navigationController?.popViewController(animated: true)
        }
        
        
    }
    
    @objc func segmentIndexChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
            case 0:
                print("high")
                
            case 1:
                print("middle")
            case 2:
                print("low")
            default:
                break
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
        
        view.addSubview(segmentedControl)
        segmentedControl.setWidth(70, forSegmentAt: 0)
        segmentedControl.setWidth(70, forSegmentAt: 1)
        segmentedControl.setWidth(70, forSegmentAt: 2)
        segmentedControl.center = view.center
    }

}
