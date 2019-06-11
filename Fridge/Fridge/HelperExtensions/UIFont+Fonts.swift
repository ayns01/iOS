//
//  UIFont+Fonts.swift
//  Fridge
//
//  Created by 酒井綾菜 on 2019-05-31.
//  Copyright © 2019 Ayana Sakai. All rights reserved.
//

import UIKit

extension UIFont {
    private static func customFont(name: String, size: CGFloat) -> UIFont {
        let font = UIFont(name: name, size: size)
        assert(font != nil, "Can't load font: \(name)")
        return font ?? UIFont.systemFont(ofSize: size)
    }
    
    static func mainFont(ofSize size: CGFloat) -> UIFont {
        return customFont(name: "Lato-Light", size: size)
    }
    
    static func regularFont(ofSize size: CGFloat) -> UIFont {
        return customFont(name: "Lato-Regular", size: size)
    }
    
    static func heavyFont(ofSize size: CGFloat) -> UIFont {
        return customFont(name: "Lato-Heavy", size: size)
    }
    
    static func boldFont(ofSize size: CGFloat) -> UIFont {
        return customFont(name: "Lato-Bold", size: size)
    }
}
