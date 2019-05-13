//
//  ViewController.swift
//  UserDefaultExample
//
//  Created by 酒井綾菜 on 2019-05-13.
//  Copyright © 2019 Ayana Sakai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var bluetoothSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        
        if defaults.object(forKey: "switch") != nil {
            bluetoothSwitch.isOn = defaults.bool(forKey: "switch")
        }
    }

    @IBAction func saveSwitchState(_ sender: UISwitch) {
        // save the state of the switch
        // -> "Userdefaults"
        
        // 1. get the userdefaults object
        let defaults = UserDefaults.standard
        
        // 2. save the state
        if sender.isOn {
            defaults.set(true, forKey: "switch")
        }else {
            defaults.set(false, forKey: "switch")
        }
    }
    
}

