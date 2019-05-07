//
//  NetworkService.swift
//  AppleStore
//
//  Created by 酒井綾菜 on 2019-05-06.
//  Copyright © 2019 Ayana Sakai. All rights reserved.
//

import Foundation

// singleton  -  1 instance only

class NetworkService {
    static let shared = NetworkService()
    
    private init() {}
    
    func fetchSearchResultApps(srarchTerm: String, completion: @escaping ([ResultApp], Error?) -> ()) {
        // 1. url
        let urlStr = "https://itunes.apple.com/search?term=\(srarchTerm)&entity=software"
        guard let url = URL(string: urlStr) else { return }
        // 2. send a request
        URLSession.shared.dataTask(with: url) {(data, response, error ) in
            
            if let err = error {
                print("Failed to fetch apps", err)
                completion([], err)
                return
            }
            
            guard let data = data else { return }
            do {
                // 3. parse response
                let searchResult = try JSONDecoder().decode(SearchResultApp.self, from: data)
                completion(searchResult.results, nil)
         
            } catch let jsonError {
                print("Failed to decode jSon", jsonError)
                completion([], jsonError)
            }
        }.resume() // fires!
        
    }
    
}
