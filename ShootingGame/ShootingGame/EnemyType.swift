//
//  EnemyType.swift
//  ShootingGame
//
//  Created by 酒井綾菜 on 2019-08-07.
//  Copyright © 2019 Ayana Sakai. All rights reserved.
//

import SpriteKit

// API通信などで取得したJSONなどを任意のデータ型に変換するプロトコル
struct EnemyType: Codable {
    let name: String
    let shields: Int
    let speed: CGFloat
    let powerUpChance: Int
}
