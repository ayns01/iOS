//
//  ViewController.swift
//  SegueStoryboard
//
//  Created by 酒井綾菜 on 2019-04-25.
//  Copyright © 2019 Ayana Sakai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var phoneTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // prepare segue after defining id for segue
    // segue: knows where you're going
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let identifier = segue.identifier {
            switch identifier {
            case "GoSecond" :
                if let vc = segue.destination as? SecondViewController {
                    // This preparatin is happening before outlets not set!
                    vc.phoneNum = phoneTextField.text
                }
            default:
                break
            }
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        // when you wanna perform segue conditionally
        return true
    }
    
    @IBAction func goToSecondVC(_ sender: UIButton) {
    }
    
    
}

