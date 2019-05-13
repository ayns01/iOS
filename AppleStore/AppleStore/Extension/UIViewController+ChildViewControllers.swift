//
//  UIViewController+ChildViewControllers.swift
//  AppleStore
//
//  Created by 酒井綾菜 on 2019-05-08.
//  Copyright © 2019 Ayana Sakai. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.view.matchParent()
        child.didMove(toParent: self)
    }
    
    func remove() {
        // Just to be safe, we check that this view controller
        // is actually added to a parent before removing it
        guard parent != nil else { return }
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
