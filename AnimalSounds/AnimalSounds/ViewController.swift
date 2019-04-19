//
//  ViewController.swift
//  AnimalSounds
//
//  Created by 酒井綾菜 on 2019-04-16.
//  Copyright © 2019 Ayana Sakai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var animalSoundLabel: UILabel!
    
    let meowSound = SimpleSound(named: "meow")
    let woofSound = SimpleSound(named: "woof")
    let mooSound = SimpleSound(named: "moo")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func catButtTapped(_ sender: Any) {
        animalSoundLabel.text = "Meow"
        meowSound.play()
    }
    
    
    @IBAction func dogButtTapped(_ sender: Any) {
        animalSoundLabel.text = "Woof"
        woofSound.play()
    }
    
    
    @IBAction func cawButtTapped(_ sender: Any) {
        animalSoundLabel.text = "Moo"
        mooSound.play()
    }
}

