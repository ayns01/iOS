//
//  DetailViewController.swift
//  TodoApp
//
//  Created by 酒井綾菜 on 2019-05-02.
//  Copyright © 2019 Ayana Sakai. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var todo: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let todoDetailLabel: UILabel = UILabel(title: todo, color: .black, fontSize: 30, bold: true)
        view.addSubview(todoDetailLabel)
        todoDetailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        todoDetailLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

    }
}
