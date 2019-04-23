//
//  ViewController.swift
//  FinalProject
//
//  Created by 酒井綾菜 on 2019-04-23.
//  Copyright © 2019 Ayana Sakai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var appSign: UILabel!
    @IBOutlet weak var rock: UIButton!
    @IBOutlet weak var sciesor: UIButton!
    @IBOutlet weak var paper: UIButton!
    @IBOutlet weak var playAgain: UIButton!
    @IBOutlet weak var gameStatus: UILabel!

    
    private var state: GameState = .Start
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    private func updateUI() {
        switch state {
        case .Start:
            gameStatus.text = "Rock, Paper, Scissors"
            view.backgroundColor = .white
            playAgain.isHidden = true
            
        case .Win:
            gameStatus.text = "You won"
            view.backgroundColor = .blue
            playAgain.isHidden = false
            
        case .Draw:
            gameStatus.text = "Draw"
            view.backgroundColor = .yellow
            playAgain.isHidden = false
            
        case .Lose:
            gameStatus.text = "You lose"
            view.backgroundColor = .red
            playAgain.isHidden = false
        }
    }

    @IBAction func play(_ sender: UIButton) {
        // tap on either choice
        let compSign = randomSign()
        appSign.text = compSign.emoji
        
        var mySign: Sign
        if sender.tag == 1 {
            mySign = Sign.Rock
            state = mySign.getGameState(other: compSign)
        } else if sender.tag == 2 {
            mySign = Sign.Paper
            state = mySign.getGameState(other: compSign)
        } else if sender.tag == 3 {
            mySign = Sign.Scissors
            state = mySign.getGameState(other: compSign)
        }
        updateUI()
    }

    @IBAction func playAgain(_ sender: Any) {
        state = .Start
        updateUI()
    }
    
}

