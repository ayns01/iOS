//
//  UIButton+ConstraintLayout.swift
//  Fridge
//
//  Created by 酒井綾菜 on 2019-06-12.
//  Copyright © 2019 Ayana Sakai. All rights reserved.
//

import UIKit

extension UIButton {
    
    func selectedButton(title:String, iconName: String) {
        
//        self.backgroundColor = UIColor(red: 0, green: 118/255, blue: 254/255, alpha: 1)
        self.setTitle(title, for: .normal)
        self.setTitle(title, for: .highlighted)
        self.setTitleColor(UIColor.white, for: .normal)
        self.setTitleColor(UIColor.white, for: .highlighted)
        self.setImage(UIImage(named: iconName), for: .normal)
        self.setImage(UIImage(named: iconName), for: .highlighted)
        let imageWidth = self.imageView!.frame.width
        let textWidth = (title as NSString).size(withAttributes:[NSAttributedString.Key.font:self.titleLabel!.font!]).width
        let width = textWidth + imageWidth + 24
        
//        widthConstraints.constant = width
        self.layoutIfNeeded()
    }
}
