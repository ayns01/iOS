//
//  UsebyCardTableViewCell.swift
//  Fridge
//
//  Created by 酒井綾菜 on 2019-05-29.
//  Copyright © 2019 Ayana Sakai. All rights reserved.
//

import UIKit

class UsebyCardCollectionViewCell: UICollectionViewCell {
    
    let nameLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "Grape"
        lb.font = .mainFont(ofSize: 25)
        lb.textColor = .basicDarkBlue
        return lb
    }()
    
    let expirationCountDateLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "1day"
        lb.font = .mainFont(ofSize: 23)
        lb.textColor = UIColor.black
        return lb
    }()
    
    let usebyTextLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "Use by/ "
        lb.font = .mainFont(ofSize: 20)
        lb.textColor = .basicDarkBlue
        return lb
    }()
    
    let usebyDetailDateLbel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "23 Jun 2019"
        lb.font = .mainFont(ofSize: 23)
        lb.textColor = .basicDarkBlue
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(nameLabel)
        nameLabel.anchors(topAnchor: topAnchor, leadingAnchor: leadingAnchor, trailingAnchor: nil, bottomAnchor: nil, padding: .init(top: 15, left: 15, bottom: 0, right: 0))
        
        addSubview(expirationCountDateLabel)
        expirationCountDateLabel.anchors(topAnchor: topAnchor, leadingAnchor: nil, trailingAnchor: trailingAnchor, bottomAnchor: nil, padding: .init(top: 15, left: 0, bottom: 0, right: 15))
        
        let hStackView = UIStackView(arrangedSubviews: [usebyTextLabel, usebyDetailDateLbel])
        hStackView.translatesAutoresizingMaskIntoConstraints = false
        hStackView.distribution = .fillProportionally
        hStackView.axis = .horizontal
        hStackView.spacing = 0
        
        addSubview(hStackView)
        hStackView.trailingAnchor.constraint(equalTo:trailingAnchor, constant: -15).isActive = true
        hStackView.bottomAnchor.constraint(equalTo:bottomAnchor, constant: -5).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
