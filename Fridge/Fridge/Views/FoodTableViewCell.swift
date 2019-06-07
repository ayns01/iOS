//
//  FoodTableViewCell.swift
//  Fridge
//
//  Created by 酒井綾菜 on 2019-06-05.
//  Copyright © 2019 Ayana Sakai. All rights reserved.
//

import UIKit

class FoodTableViewCell: UITableViewCell {
    
    let foodNameLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = .mainFont(ofSize: 21)
        lb.textColor = .basicDarkBlue
        return lb
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        addSubview(foodNameLabel)
        foodNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        foodNameLabel.leadingAnchor.constraint(equalTo:  leadingAnchor, constant: 20).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
