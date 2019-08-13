//
//  MenuScene.swift
//  ShootingGame
//
//  Created by 酒井綾菜 on 2019-08-11.
//  Copyright © 2019 Ayana Sakai. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {
    
    var newGameButtonNode: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        createStarDust()
        
        newGameButtonNode = self.childNode(withName: "newGameButton") as? SKSpriteNode
    }
    
    func createStarDust() {
        if let particles = SKEmitterNode(fileNamed: "Starfield") {
            particles.position = CGPoint(x: frame.maxX / 2, y: frame.maxY)
            particles.advanceSimulationTime(60)
            particles.zPosition = 0
            addChild(particles)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        
        if let location = touch?.location(in: self) {
            let nodesArray = self.nodes(at: location)
            
            if nodesArray.first?.name == "newGameButton" {
                if let gameScene = SKScene(fileNamed: "GameScene") {
                    // Set the scale mode to scale to fit the window
                    gameScene.scaleMode = .aspectFill
                    
                    // Present the scene
                    self.view!.presentScene(gameScene)
                }
            }
        }
    }
}
