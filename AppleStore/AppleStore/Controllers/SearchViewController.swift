//
//  SearchViewController.swift
//  AppleStore
//
//  Created by 酒井綾菜 on 2019-04-25.
//  Copyright © 2019 Ayana Sakai. All rights reserved.
//

import UIKit
import SDWebImage

enum SearchState {
    case trending
    case suggestion
    case final
}

// Trending page
class SearchViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    fileprivate var searchResults = [ResultApp]()
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    private var searchState: SearchState = .trending
    private var timer: Timer?
    
    private let cellId = "trendingCell"
    private let trendings = ["Instagram", "facebook", "Tinder", "Snapchat", "Google"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        
        collectionView.register(SearchCollectionViewCell.self,
                                forCellWithReuseIdentifier: cellId)
        
        setupSearchBar()
    }
    
    fileprivate func setupSearchBar() {
        navigationItem.searchController = self.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            NetworkService.shared.fetchSearchResultApps(srarchTerm: searchText) { (results, err) in self.searchResults = results
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                
            }
        })
        
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 350)
    }
    
    
    // MARK: DataSource
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // downCasting: UICollectionViewCell -> SearchCollectionViewCell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchCollectionViewCell
        
        cell.nameLabel.text = searchResults[indexPath.row].trackName
        cell.categoryLabel.text = searchResults[indexPath.row].primaryGenreName
        cell.categoryLabel.text = "\(searchResults[indexPath.row].averageUserRating ?? 0)"
        let iconUrl = URL(string: searchResults[indexPath.row].artworkUrl100)
        cell.iconImageView.sd_setImage(with: iconUrl)

        cell.screenShot1.sd_setImage(with: URL(string: searchResults[indexPath.row].screenshotUrls[0]))
        
        cell.screenShot2.sd_setImage(with: URL(string: searchResults[indexPath.row].screenshotUrls[1]))
        
        cell.screenShot3.sd_setImage(with: URL(string: searchResults[indexPath.row].screenshotUrls[2]))
        
        
        
        return cell
    }
    
    init() {
        
    super.init(collectionViewLayout: UICollectionViewFlowLayout())

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
