//
//  GameScene.swift
//  Game
//
//  Created by 酒井綾菜 on 2019-08-23.
//  Copyright © 2019 Ayana Sakai. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var player : SKNode?
    private var bear = SKSpriteNode()
    private var bearWalkingFrames: [SKTexture] = []
    
    // Sprite Engine
    var previousTimeInterval : TimeInterval = 0
    var playerIsFacingRight = true
    let playerSpeed = 30.0
    
    var playerWarkingState = 0.0
    let knobRadius = CGFloat(3.0)
    var joystickKnob = CGPoint(x: 0, y: 0)
    
    // Player state
    var playerStateMachine : GKStateMachine!
    
    override func didMove(to view: SKView) {
   
        player = childNode(withName: "player")
//        let textures : Array<SKTexture> = (0..<6).map({ return "player/\($0)"}).map(SKTexture.init)
//        let action = { SKAction.repeatForever(.animate(with: textures, timePerFrame: 0.1))} ()
//        player?.run(action)
        playerStateMachine = GKStateMachine(states: [])
        
        playerStateMachine = GKStateMachine(states: [
            JumpingState(playerNode: player!),
            WalkingState(playerNode: player!),
            IdleState(playerNode: player!)
            ])
        
        playerStateMachine.enter(IdleState.self)
    }
    
    

}

extension GameScene {
    // Touch Began
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
        }
    }
    
    // Touch Moved
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let position = touch.location(in: self)
//            playerWarkingState = Double(position.x) / Double(position.x)
            let length = sqrt(pow(position.y, 2) + pow(position.x, 2))
            let angle = atan2(position.y, position.x)

            if knobRadius > length {
                joystickKnob = position
            } else {
                joystickKnob = CGPoint(x: cos(angle) * knobRadius, y: sin(angle) * knobRadius)
            }
        }
    }
    
    // Touch Ended
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
//        playerWarkingState = 0
        joystickKnob = CGPoint(x: 0, y: 0)
    }
}

// MARK: Game Loop
extension GameScene {
    override func update(_ currentTime: TimeInterval) {
        let deltaTime = currentTime - previousTimeInterval
        previousTimeInterval = currentTime
        
        let xPosition = joystickKnob.x
        
        // Player movement
        let positivePosition = xPosition < 0 ? -xPosition : xPosition
        
        if floor(positivePosition) != 0 {
            playerStateMachine.enter(WalkingState.self)
        } else {
            playerStateMachine.enter(IdleState.self)
        }
        
//        let displacement = CGVector(dx: deltaTime * Double(playerWarkingState) * playerSpeed, dy: 0)
        let displacement = CGVector(dx: deltaTime * Double(xPosition) * playerSpeed, dy: 0)

        let move = SKAction.move(by: displacement, duration: 0)
//        player?.run(move)
        
        let faceAction : SKAction!
        let movingRight = xPosition > 0
        let movingLeft = xPosition < 0
        if movingLeft && playerIsFacingRight {
            playerIsFacingRight = false
            let faceMovement = SKAction.scaleX(to: -1, duration: 0.0)
            faceAction = SKAction.sequence([move, faceMovement])
        }
        else if movingRight && !playerIsFacingRight {
            playerIsFacingRight = true
            let faceMovement = SKAction.scaleX(to: 1, duration: 0.0)
            faceAction = SKAction.sequence([move, faceMovement])
        } else {
            faceAction = move
        }
        player?.run(faceAction)
    }
}
