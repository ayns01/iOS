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
        iv.layer.cornerRadius = 12
        iv.widthAnchor.constraint(equalToConstant: 64).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 64).isActive = true
        
        
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
        butt.setTitleColor(.blue, for: .normal)
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
        wholeStackView.spacing = 16
        
        addSubview(wholeStackView)
        
        
        // set constraints
//        wholeStackView.translatesAutoresizingMaskIntoConstraints = false
        wholeStackView.matchParent(padding: .init(top: 16, left: 16, bottom: -16, right: -16))

//        NSLayoutConstraint.activate([
//            wholeStackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
//            wholeStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
//            wholeStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
//            wholeStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
//            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//extension UIView {
//    func matchParent(padding: UIEdgeInsets = .zero) {
//        translatesAutoresizingMaskIntoConstraints = false
//        if let superTopAnchor = superview?.topAnchor {
//            self.topAnchor.constraint(equalTo: superTopAnchor, constant: padding.top).isActive = true
//        }
//        if let superBottomAnchor = superview?.bottomAnchor {
//            self.bottomAnchor.constraint(equalTo: superBottomAnchor, constant: -padding.bottom).isActive = true
//        }
//        if let superLeadingAnchor = superview?.leadingAnchor {
//            self.leadingAnchor.constraint(equalTo: superLeadingAnchor, constant: padding.left).isActive = true
//        }
//        if let superTrailingAnchor = superview?.trailingAnchor {
//            self.trailingAnchor.constraint(equalTo: superTrailingAnchor, constant: -padding.right).isActive = true
//        }
//    }
//}
