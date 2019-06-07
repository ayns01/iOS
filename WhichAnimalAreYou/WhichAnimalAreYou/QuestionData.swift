//
//  QuestionData.swift
//  WhichAnimalAreYou
//
//  Created by 酒井綾菜 on 2019-05-29.
//  Copyright © 2019 Ayana Sakai. All rights reserved.
//

import Foundation

struct Question {
    var text: String
    var type: ResponseType
    var answers: [Answer]
}

enum ResponseType {
    case single, multiple, ranged
}

