//
//  Wave.swift
//  ShootingGame
//
//  Created by 酒井綾菜 on 2019-08-13.
//  Copyright © 2019 Ayana Sakai. All rights reserved.
//

import SpriteKit

struct Wave: Codable {
    struct WaveEnemy: Codable {
        var position: Int
        var xOffset: CGFloat
        var moveStraight: Bool
    }
    
    var name: String
    var enemies: [WaveEnemy]
}
