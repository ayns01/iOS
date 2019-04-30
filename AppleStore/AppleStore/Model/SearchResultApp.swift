//
//  SearchResultApp.swift
//  AppleStore
//
//  Created by 酒井綾菜 on 2019-04-29.
//  Copyright © 2019 Ayana Sakai. All rights reserved.
//

import Foundation

struct SearchResultApp: Decodable {
    let resultCount: Int
    let results: [ResultApp]
    
}

struct ResultApp: Decodable {
    let trackName: String
    let primaryGenreName: String
}
