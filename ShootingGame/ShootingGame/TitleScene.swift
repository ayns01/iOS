//
//  TitleScene.swift
//  ShootingGame
//
//  Created by 酒井綾菜 on 2019-08-11.
//  Copyright © 2019 Ayana Sakai. All rights reserved.
//

import SpriteKit

class TitleScene: SKScene {
    override func didMove(to view: SKView) {
        let myLabel = SKLabelNode()
        myLabel.position = CGPoint(x: frame.size.width * 0.15, y: frame.size.height * 0.88)
        myLabel.zPosition = 10
        myLabel.fontColor = #colorLiteral(red: 0.5855464339, green: 0.9720957875, blue: 0.6153635979, alpha: 1)
        myLabel.fontSize = 20
        myLabel.fontName = "AvenirNext-Bold"
        myLabel.horizontalAlignmentMode = .left
        myLabel.text = "Start"
        addChild(myLabel)
    }
    
    //画面タッチ時の呼び出しメソッド
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("タッチしました。")
    }
}
