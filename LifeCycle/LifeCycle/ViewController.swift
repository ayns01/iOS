//
//  ViewController.swift
//  LifeCycle
//
//  Created by 酒井綾菜 on 2019-05-09.
//  Copyright © 2019 Ayana Sakai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // when viewController loads all the view into Memory.
        // (not yet visible)
        // this process create the views that the controller wikk manage.
        // Gets called once when the views are loaded to the Memory
        // Initialization of views (set attributes of views)
        print("ViewController - view did load")
    }
    
    
    // This method gets called right before the view is displayed (everytime).
    // 1. updating user location
    // 2. updating or refreshing some 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("ViewController - view will appear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("ViewController - view did appear")
    }
    
    // These methods execute
    // by tapping the back button, switching tabs, or presenting or dismissing a modal view controller.
    // Gets called right before the disappear from the screen.
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("ViewController - view will disappear")
        
    }
    
    // 
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("ViewController - view did disappear")
    }


}

