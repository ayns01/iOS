//
//  GameScene.swift
//  ShootingGame
//
//  Created by 酒井綾菜 on 2019-08-06.
//  Copyright © 2019 Ayana Sakai. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    override func didMove(to view: SKView) {
        if let particles = SKEmitterNode(fileNamed: "Starfield") {
            particles.position = CGPoint(x: 1000, y: 0)
            particles.zPosition = -1
            addChild(particles)
        }
    }

}
