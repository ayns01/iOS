//
//  ViewController.swift
//  MemeMaker
//
//  Created by 酒井綾菜 on 2019-04-23.
//  Copyright © 2019 Ayana Sakai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var topChoices = [CaptionOption]()
    var bottomChoises = [CaptionOption]()

    @IBOutlet weak var topCaptionSegmentedControl: UISegmentedControl!
    @IBOutlet weak var bottomCaptionSegmentedControl: UISegmentedControl!
    @IBOutlet weak var topCaptionLabel: UILabel!
    @IBOutlet weak var bottomCaptionLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let coolChoice = CaptionOption(emoji: "🕶", caption: "You know what's cool?")
        let madChoice = CaptionOption(emoji: "💥", caption: "You know what makes me mad?")
        let loveChoice = CaptionOption(emoji: "💕", caption: "You know what I love?")
        topChoices = [coolChoice, madChoice, loveChoice]
        
        // remove all of the segments from the top control
        topCaptionSegmentedControl.removeAllSegments()
        for choice in topChoices {
            topCaptionSegmentedControl.insertSegment(withTitle: choice.emoji, at: topChoices.count, animated: false)
        }
        topCaptionSegmentedControl.selectedSegmentIndex = 0
        
        
        let catChoice = CaptionOption(emoji: "🐱", caption: "Cats wearing hats")
        let dogChoice = CaptionOption(emoji: "🐕", caption: "Dogs carrying logs")
        let monkeyChoice = CaptionOption(emoji: "🐒", caption: "Monkeys being funky")
        bottomChoises = [catChoice, dogChoice, monkeyChoice]
        
        bottomCaptionSegmentedControl.removeAllSegments()
        for choice in bottomChoises {
            bottomCaptionSegmentedControl.insertSegment(withTitle: choice.emoji, at: topChoices.count, animated: false)
        }
        bottomCaptionSegmentedControl.selectedSegmentIndex = 0
        
        updateUI()
        
    }
    
    @IBAction func switchTopSegmentedControl(_ sender: UISegmentedControl) {
        updateUI()
    }
    
    @IBAction func switchBottomSegmentedControl(_ sender: UISegmentedControl) {
        updateUI()
    }
    
    private func updateUI() {
        topCaptionLabel.text = topChoices[topCaptionSegmentedControl.selectedSegmentIndex].caption
        bottomCaptionLabel.text = bottomChoises[bottomCaptionSegmentedControl.selectedSegmentIndex].caption
    }
    
    
}
