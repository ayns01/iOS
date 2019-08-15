//
//  Bundle-Decoding.swift
//  ShootingGame
//
//  Created by 酒井綾菜 on 2019-08-13.
//  Copyright © 2019 Ayana Sakai. All rights reserved.
//

import Foundation

extension Bundle {
    func decode<T:Decodable>(_ type: T.Type, from file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to lacate \(file) in Bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from Bundle.")
        }
        
        let decoder = JSONDecoder()
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from Bundle.")
        }
        
        return loaded
    }
}

