//
//  EnemyNode.swift
//  ShootingGame
//
//  Created by 酒井綾菜 on 2019-08-13.
//  Copyright © 2019 Ayana Sakai. All rights reserved.
//

import SpriteKit

class EnemyNode: SKSpriteNode {
    var type: EnemyType
    var lastFireTime: Double = 0
    var shields: Int
    
    init(type: EnemyType, startPosition: CGPoint, xOffset: CGFloat, moveStraight: Bool) {
        self.type = type
        self.shields = type.shields
        
        let texture = SKTexture(imageNamed: type.name)
        super.init(texture: texture, color: .white, size: texture.size())
        
        physicsBody = SKPhysicsBody(texture: texture, size: texture.size())
        physicsBody?.categoryBitMask = UInt32(PhysicsCategories.enemy)
        physicsBody?.collisionBitMask = UInt32(PhysicsCategories.player | PhysicsCategories.laser)
        physicsBody?.contactTestBitMask = UInt32(PhysicsCategories.player | PhysicsCategories.laser)
        name = "enemy"
        position = CGPoint(x: startPosition.x + xOffset, y: startPosition.y)
        
        configureMovement(moveStraight)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureMovement(_ moveStraight: Bool) {
        let path = UIBezierPath()
//        path.move(to: .zero)
        path.move(to: CGPoint(x:0, y:100))
        path.addCurve(to: CGPoint(x:187.5, y:100), controlPoint1: CGPoint(x:75, y:40), controlPoint2: CGPoint(x:100, y:100))
        
//        if moveStraight {
//            path.addLine(to: CGPoint(x: 300, y: 0))
//        }else {
//            path.addCurve(to: CGPoint(x: -500, y: 0), controlPoint1: CGPoint(x: 0, y: position.y), controlPoint2: CGPoint(x: -100, y: position.y * 0.5))
//        }
        
        let movement = SKAction.follow(path.cgPath, asOffset: true, orientToPath: true, duration: 5)
        
        let moveReset = SKAction.removeFromParent()
        
        let moveSequence = SKAction.sequence([movement, moveReset])
        
        run(moveSequence)
    }
    
}
