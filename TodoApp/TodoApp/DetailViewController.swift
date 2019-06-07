//
//  DetailViewController.swift
//  TodoApp
//
//  Created by 酒井綾菜 on 2019-05-02.
//  Copyright © 2019 Ayana Sakai. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var todoTitle: String!
    var todoPriority: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let todoDetailTitleLabel: UILabel = UILabel(title: todoTitle, color: .black, fontSize: 20, bold: true)
        let todoDetailPriorLabel: UILabel = UILabel(title: todoPriority, color: .orange, fontSize: 13, bold: true)
        let stackView = UIStackView(arrangedSubviews: [todoDetailTitleLabel, todoDetailPriorLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 50
        view.addSubview(stackView)
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

    }
}
