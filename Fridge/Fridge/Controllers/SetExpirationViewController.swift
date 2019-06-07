//
//  SetExpirationViewController.swift
//  Fridge
//
//  Created by 酒井綾菜 on 2019-06-05.
//  Copyright © 2019 Ayana Sakai. All rights reserved.
//

import UIKit

class SetExpirationViewController: UIViewController {
    
    var categoryName: String!
    var foodName: String!
    
    let categoryNameLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = .mainFont(ofSize: 30)
        lb.textColor = .basicDarkBlue
        return lb
    }()
    
    let foodNameLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = .mainFont(ofSize: 25)
        lb.textColor = .basicDarkBlue
        return lb
    }()
    
    let usebydateTitleLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = .mainFont(ofSize: 25)
        lb.text = "Use by Date"
        lb.textColor = .basicDarkBlue
        return lb
    }()
    
    let usebyDatePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.backgroundColor = .white
        picker.contentMode = .center
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    let quantityTitleLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = .mainFont(ofSize: 20)
        lb.textColor = .basicDarkBlue
        return lb
    }()
    
//    let quantityNumField: UITextField = {
//        let lb = UILabel()
//        lb.translatesAutoresizingMaskIntoConstraints = false
//        lb.font = .mainFont(ofSize: 20)
//        lb.textColor = .basicDarkBlue
//        return lb
//    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bgGrey
        
        categoryNameLabel.text = categoryName
        foodNameLabel.text = foodName
        
        let vFoodStackView = UIStackView(arrangedSubviews: [categoryNameLabel, foodNameLabel])
        vFoodStackView.translatesAutoresizingMaskIntoConstraints = false
        vFoodStackView.distribution = .fillProportionally
        vFoodStackView.axis = .vertical
        vFoodStackView.spacing = 0
        
        view.addSubview(vFoodStackView)
        vFoodStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        vFoodStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 35).isActive = true
//        vFoodStackView.anchors(topAnchor: view.safeAreaLayoutGuide.topAnchor, leadingAnchor: view.leadingAnchor, trailingAnchor: view.trailingAnchor, bottomAnchor: nil, padding: .init(top: 35, left: 0, bottom: 0, right: 0))
        
        view.addSubview(usebydateTitleLabel)
        usebydateTitleLabel.anchors(topAnchor: vFoodStackView.bottomAnchor, leadingAnchor: view.leadingAnchor, trailingAnchor: nil, bottomAnchor: nil, padding: .init(top: 30, left: 15, bottom: 0, right: 0))
        
        view.addSubview(usebyDatePicker)
        usebyDatePicker.anchors(topAnchor: usebydateTitleLabel.bottomAnchor, leadingAnchor: view.leadingAnchor, trailingAnchor: view.trailingAnchor, bottomAnchor: nil)

        
    }

}
