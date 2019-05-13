//
//  SearchCollectionViewCell.swift
//  AppleStore
//
//  Created by 酒井綾菜 on 2019-04-29.
//  Copyright © 2019 Ayana Sakai. All rights reserved.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell {
    let iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .blue
        iv.widthAnchor.constraint(equalToConstant: 64).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 64).isActive = true
        iv.layer.cornerRadius = 12
        iv.clipsToBounds = true
        return iv
    }()
    
    let nameLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Instagram"
        return lb
    }()
    
    let categoryLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Photos & Videos"
        return lb
    }()
    
    let ratingLabel: UILabel = {
        let lb = UILabel()
        lb.text = "991K"
        return lb
    }()
    
    let getButt: UIButton = {
        let butt = UIButton(type: .system)
        butt.setTitle("GET", for: .normal)
        butt.setTitleColor(.darkGray, for: .normal)
        butt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        butt.backgroundColor = UIColor(white: 0.95, alpha: 1)
        butt.widthAnchor.constraint(equalToConstant: 80).isActive = true
        butt.heightAnchor.constraint(equalToConstant: 32).isActive = true
        butt.layer.cornerRadius = 16
        return butt
    }()

    // lazy: sereenShot1 is an instance but createScreenShotImageView() is also an instance.
    lazy var screenShot1: UIImageView = createScreenShotImageView()
    lazy var screenShot2: UIImageView = createScreenShotImageView()
    lazy var screenShot3: UIImageView = createScreenShotImageView()
    
    fileprivate func createScreenShotImageView() -> UIImageView {
        let iv = UIImageView()
        iv.backgroundColor = .green
        iv.layer.cornerRadius = 7
        iv.clipsToBounds = true
        iv.layer.borderWidth = 0.5
        iv.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
        iv.contentMode = .scaleAspectFill
        return iv
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let labelsSv = UIStackView(arrangedSubviews: [
            nameLabel, categoryLabel, ratingLabel
            ])
        labelsSv.axis = .vertical
        
        let appInfoStackView = UIStackView(arrangedSubviews: [
            iconImageView, labelsSv, getButt
            ])
            appInfoStackView.spacing = 12
            appInfoStackView.alignment = .center
        
        let screenShotsStackView = UIStackView(arrangedSubviews: [
            screenShot1, screenShot2, screenShot3
            ])
        screenShotsStackView.spacing = 12
        screenShotsStackView.distribution = .fillEqually
        
        let wholeStackView = UIStackView(arrangedSubviews: [
            appInfoStackView, screenShotsStackView
            ])
        wholeStackView.axis = .vertical
        addSubview(wholeStackView)
        wholeStackView.spacing = 16
        wholeStackView.matchParent(padding: UIEdgeInsets.init(top: 16, left: 16, bottom: 16, right: 16))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
