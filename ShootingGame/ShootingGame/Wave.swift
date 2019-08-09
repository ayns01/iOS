//
//  Wave.swift
//  ShootingGame
//
//  Created by 酒井綾菜 on 2019-08-06.
//  Copyright © 2019 Ayana Sakai. All rights reserved.
//

import SpriteKit

struct Wave: Codable {
    struct WaveEnemy: Codable {
        let position: Int
        let xOffset: CGFloat
        let moveStraight: Bool
    }
    
    let name: String
    let enemies: [WaveEnemy]
    
}


