//
//  MiddleViewController.swift
//  OrderOfEvents
//
//  Created by 酒井綾菜 on 2019-05-09.
//  Copyright © 2019 Ayana Sakai. All rights reserved.
//

import UIKit

class MiddleViewController: UIViewController {

    @IBOutlet var middleViewLabel: UILabel!
    var eventNumber: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Middle - view did load")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let existingText = middleViewLabel.text {
            middleViewLabel.text = "\(existingText)\nEvent Number \(eventNumber) was loaded."
            eventNumber += 1
            print("Middle - view will appear")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let existingText = middleViewLabel.text {
            middleViewLabel.text = "\(existingText)\nEvent Number \(eventNumber) was loaded."
            eventNumber += 1
            print("Middle - view did appear")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let existingText = middleViewLabel.text {
            middleViewLabel.text = "\(existingText)\nEvent Number \(eventNumber) was loaded."
            eventNumber += 1
            print("Middle - view will disappear")

        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if let existingText = middleViewLabel.text {
            middleViewLabel.text = "\(existingText)\nEvent Number \(eventNumber) was loaded."
            eventNumber += 1
            print("Middle - view did disappear")
        }
    }
}
