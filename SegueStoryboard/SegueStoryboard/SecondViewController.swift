//
//  SecondViewController.swift
//  SegueStoryboard
//
//  Created by 酒井綾菜 on 2019-04-25.
//  Copyright © 2019 Ayana Sakai. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var phoneLabel: UILabel! {
        didSet {
            phoneLabel.text = phoneNum
        }
    }
    var phoneNum: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

}
