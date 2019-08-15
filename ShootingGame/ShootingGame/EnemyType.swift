//
//  EnemyType.swift
//  ShootingGame
//
//  Created by 酒井綾菜 on 2019-08-13.
//  Copyright © 2019 Ayana Sakai. All rights reserved.
//

import SpriteKit

struct EnemyType: Codable {
    var name: String
    var shields: Int
    var speed: CGFloat
    var powerUpChance: Int
}


