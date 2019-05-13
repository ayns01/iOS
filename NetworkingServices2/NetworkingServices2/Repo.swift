//
//  Repo.swift
//  NetworkingServices2
//
//  Created by 酒井綾菜 on 2019-05-08.
//  Copyright © 2019 Ayana Sakai. All rights reserved.
//

import Foundation

class Repo: Decodable {
    let id: Int
    let name: String
    let full_name: String
    let clone_url: String
    let created_at: String
}
