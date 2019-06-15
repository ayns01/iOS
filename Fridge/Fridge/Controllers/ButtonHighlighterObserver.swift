//
//  ButtonHighlighterObserver.swift
//  Fridge
//
//  Created by 酒井綾菜 on 2019-06-13.
//  Copyright © 2019 Ayana Sakai. All rights reserved.
//

import UIKit

public class ButtonHighlighterObserver: NSObject {
    
    var observedButton:UIButton? = nil
    
    var backgroundColor: UIColor            = UIColor.white
    var backgroundHighlightColor: UIColor   = UIColor.gray
    
    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        // Perform background color changes when highlight state change is observed
        if keyPath == "highlighted", object as? UIButton === observedButton {
            observedButton!.backgroundColor = observedButton!.isHighlighted ? self.backgroundHighlightColor : self.backgroundColor
        }
    }
}

