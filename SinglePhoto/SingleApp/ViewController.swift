//
//  ViewController.swift
//  SingleApp
//
//  Created by 酒井綾菜 on 2019-04-15.
//  Copyright © 2019 Ayana Sakai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // create a button to go to the NextViewController programatically
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = UIColor.red
        let width = view.frame.size.width / 2 - 50
        let height = view.frame.size.height / 2 - 50
        let nextBtn = UIButton(frame: CGRect(x: width, y: height, width: 100, height: 100))
        nextBtn.setTitle("Next", for: .normal)
        view.addSubview(nextBtn)
        nextBtn.addTarget(self, action: #selector(pushToNextVC), for: .touchUpInside)
    }
    
    @objc func pushToNextVC() {
        let nextVC = NextViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}

