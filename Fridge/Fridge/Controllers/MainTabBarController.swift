//
//  MainTabBarController.swift
//  Fridge
//
//  Created by 酒井綾菜 on 2019-05-31.
//  Copyright © 2019 Ayana Sakai. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [
            createViewController(viewController: UsebyCardCollectionViewController(), title: "Fridge", imageName: "games"),
            createViewController(viewController: ShoppingListTableViewController(), title: "Shopping", imageName: "games")
        ]
    
    }
    
    fileprivate func createViewController(viewController: UIViewController, title: String, imageName: String) -> UIViewController {
        
//        viewController.view.backgroundColor = .white
//        viewController.navigationItem.title = title
        let navController = UINavigationController(rootViewController: viewController)
//        navController.navigationBar.prefersLargeTitles = true
//        navController.navigationBar.barTintColor = .eggYellow
//        navController.navigationBar.isTranslucent = false
        navController.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navController.navigationBar.shadowImage = UIImage()
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(named: imageName)
        return navController
    }

}
