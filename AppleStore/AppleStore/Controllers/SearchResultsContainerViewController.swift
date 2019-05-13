//
//  SearchResultsContainerViewController.swift
//  AppleStore
//
//  Created by 酒井綾菜 on 2019-05-08.
//  Copyright © 2019 Ayana Sakai. All rights reserved.
//

import UIKit

class SearchResultsContainerViewController: UIViewController {

    private var suggestionTableViewController: SearchResultsContainerViewController!
    var previousViewController: UIViewController?
    
    // MARK: Life cycle mathods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        suggestionTableViewController = SearchSuggestionTableViewController()
    }
    
    func
    
    //MARK: transitions
    
    extension SearchResultsContainerViewController {
        func transition(from fromViewController: UIViewController, to toViewController: UIViewController, duration: TimeInterval, options: UIView.AnimationOptions = [], animations: (() -> Void)?, completion: ((Bool) -> Void)? = nil) {
            <#code#>
        }            previousViewController?.remove()
            add(viewController)
            previousViewController = viewController
        }
    }
    

}
