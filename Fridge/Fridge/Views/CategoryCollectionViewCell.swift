//
//  CategoryCollectionViewCell.swift
//  Fridge
//
//  Created by 酒井綾菜 on 2019-06-04.
//  Copyright © 2019 Ayana Sakai. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    let categoryNameLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = .regularFont(ofSize: 17)
        lb.textColor = .basicDarkBlue
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(categoryNameLabel)
        categoryNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        categoryNameLabel.centerYAnchor.constraint(equalTo:  centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
