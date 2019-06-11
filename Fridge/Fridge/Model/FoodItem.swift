//
//  FoodItem.swift
//  Fridge
//
//  Created by 酒井綾菜 on 2019-06-10.
//  Copyright © 2019 Ayana Sakai. All rights reserved.
//

import Firebase

struct FoodItem {
    let id: String
    let category: String
    let foodName: String
    let notification: Bool
    let quantity: Int
    let usebyDate: Date
}

