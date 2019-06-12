//
//  UsebyCardTableViewCell.swift
//  Fridge
//
//  Created by 酒井綾菜 on 2019-05-29.
//  Copyright © 2019 Ayana Sakai. All rights reserved.
//

import UIKit

class UsebyCardCollectionViewCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let nameLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = .boldFont(ofSize: 17)
        lb.textColor = .basicDarkBlue
        return lb
    }()
    
    let quantityLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = .regularFont(ofSize: 15)
        lb.textColor = .basicDarkBlue
        return lb
    }()
    
    let expirationCountDateLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let usebyTextLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "Use by/ "
        lb.font = .regularFont(ofSize: 13)
        lb.textColor = .basicDarkBlue
        return lb
    }()
    
    let usebyDetailDateLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = .boldFont(ofSize: 15)
        lb.textColor = .basicDarkBlue
        return lb
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(imageView)
        imageView.anchors(topAnchor: topAnchor, leadingAnchor: leadingAnchor, trailingAnchor: nil, bottomAnchor: nil, padding: .init(top: 15, left: 15, bottom: 0, right: 0))
        
        addSubview(nameLabel)
        nameLabel.anchors(topAnchor: topAnchor, leadingAnchor: imageView.trailingAnchor, trailingAnchor: nil, bottomAnchor: nil, padding: .init(top: 15, left: 15, bottom: 0, right: 0))
        
        addSubview(quantityLabel)
        quantityLabel.anchors(topAnchor: topAnchor, leadingAnchor: nameLabel.trailingAnchor, trailingAnchor: nil, bottomAnchor: nil, padding: .init(top: 17, left: 5, bottom: 0, right: 0))
        
        addSubview(expirationCountDateLabel)
        expirationCountDateLabel.anchors(topAnchor: topAnchor, leadingAnchor: nil, trailingAnchor: trailingAnchor, bottomAnchor: nil, padding: .init(top: 15, left: 0, bottom: 0, right: 15))
        
        let hStackView = UIStackView(arrangedSubviews: [usebyTextLabel, usebyDetailDateLabel])
        hStackView.translatesAutoresizingMaskIntoConstraints = false
        hStackView.distribution = .fillProportionally
        hStackView.axis = .horizontal
        hStackView.spacing = 0
        
        addSubview(hStackView)
        hStackView.trailingAnchor.constraint(equalTo:trailingAnchor, constant: -15).isActive = true
        hStackView.bottomAnchor.constraint(equalTo:bottomAnchor, constant: -5).isActive = true
        
        setupLayer()
    }
    
    fileprivate func setupLayer() {
        layer.cornerRadius = 8
        
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.firstColor.cgColor
        
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 15.0, height: 5.0)
        layer.shadowRadius = 0.0
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
