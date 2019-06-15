//
//  AddNewFoodViewController.swift
//  Fridge
//
//  Created by 酒井綾菜 on 2019-06-13.
//  Copyright © 2019 Ayana Sakai. All rights reserved.
//

import UIKit

class AddNewFoodViewController: UIViewController {
    
    var categoryName: String!
    
    let messageLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = .boldFont(ofSize: 18)
        lb.text = "Add New Food"
        lb.textColor = .basicDarkBlue
        return lb
    }()
    
    let newFoodTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter Food Name You Wanna Add !"
        tf.backgroundColor = .white
        tf.textColor = .basicDarkBlue
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.bgGrey.cgColor
        tf.borderStyle = UITextField.BorderStyle.roundedRect
        tf.translatesAutoresizingMaskIntoConstraints = false
        
        return tf
    }()
    
    let errMessage: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = .boldFont(ofSize: 14)
        lb.text = "Enter food name"
        lb.textColor = .basicDarkBlue
        return lb
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .bgGrey
        
        setupNavigation()
        
        view.addSubview(messageLabel)
        messageLabel.anchors(topAnchor: view.safeAreaLayoutGuide.topAnchor, leadingAnchor: view.leadingAnchor, trailingAnchor: view.trailingAnchor, bottomAnchor: nil, padding: .init(top: 35, left: 15, bottom: 0, right: 15))
        
        view.addSubview(newFoodTextField)
        newFoodTextField.anchors(topAnchor: messageLabel.bottomAnchor, leadingAnchor: view.leadingAnchor, trailingAnchor: view.trailingAnchor, bottomAnchor: nil, padding: .init(top: 20, left: 15, bottom: 0, right: 15))
        newFoodTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    fileprivate func setupNavigation() {

        let addBtn = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addPressed))
        addBtn.tintColor = .secondColor
        navigationItem.rightBarButtonItem = addBtn
    }
    
    @objc func addPressed() {
        let setExpirationVC = SetExpirationViewController()
        setExpirationVC.categoryName = categoryName
        setExpirationVC.foodName = newFoodTextField.text
        navigationController?.pushViewController(setExpirationVC, animated: true)
    }

}
