//
//  SearchViewController.swift
//  AppleStore
//
//  Created by 酒井綾菜 on 2019-04-25.
//  Copyright © 2019 Ayana Sakai. All rights reserved.
//

import UIKit
// UICollectionViewDataSource Delegate
class SearchViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let cellId = "resultCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(SearchCollectionViewCell.self,
                                forCellWithReuseIdentifier: cellId)
        
        fetchSearchResultApps()
        
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 350)
    }
    
    
    // MARK: DataSource
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // downCasting: UICollectionViewCell -> SearchCollectionViewCell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchCollectionViewCell
        return cell
    }
    
    init() {
        
    super.init(collectionViewLayout: UICollectionViewFlowLayout())

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func fetchSearchResultApps() {
        // 1. url
        let urlStr = "https://itunes.apple.com/search?term=facebook&entity=software"
        guard let url = URL(string: urlStr) else { return }
        // 2. send a request
        URLSession.shared.dataTask(with: url) {(data, response, error ) in
            
            if let err = error {
                print("Failed to fetch apps", err)
                return
            }
            
            guard let data = data else { return }
            do {
                // 3. parse response
                let searchResult = try
                    JSONDecoder().decode(SearchResultApp.self, from: data)
                searchResult.results.forEach({ (result) in
                    print(result.trackName, result.primaryGenreName)
                })
            } catch let jsonError {
                print("Failed to decode jSon", jsonError)
            }
        }.resume() // fires!
        
    }
    
}
