//
//  MainTabBarController.swift
//  Fridge
//
//  Created by 酒井綾菜 on 2019-05-31.
//  Copyright © 2019 Ayana Sakai. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    var fridgeVC: UsebyCardCollectionViewController!
    var addVC: ChooseCategoryCollectionViewController!
    var shoppingVC: ShoppingListTableViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
//        let addVC = createViewController(viewController: ChooseCategoryCollectionViewController(), title: "", imageName: "icon-plus", height: 66)
//        present(addVC, animated: true, completion: nil)
//
//
//        viewControllers = [
//            createViewController(viewController: UsebyCardCollectionViewController(), title: "Fridge", imageName: "icon-fridge"),
//            addVC,
//            createViewController(viewController: ShoppingListTableViewController(), title: "Shopping", imageName: "icon-shopping")
//        ]
        
        // Setup ViewControllers
        fridgeVC = UsebyCardCollectionViewController()
        addVC = ChooseCategoryCollectionViewController()
        shoppingVC = ShoppingListTableViewController()
        
        let navFridgeController = UINavigationController(rootViewController: fridgeVC)
//        let navAddController = UINavigationController(rootViewController: addVC)
        let navShoppingController = UINavigationController(rootViewController: shoppingVC)
        
        fridgeVC.tabBarItem.image = UIImage(named: "icon-fridge")
        fridgeVC.tabBarItem.title = ""
//        fridgeVC.tabBarItem.selectedImage = UIImage(named: "icon-fridge")
        addVC.tabBarItem.image = UIImage(named: "icon-plus")
        addVC.tabBarItem.title = ""
//        addVC.tabBarItem.selectedImage = UIImage(named: "icon-plus")
        shoppingVC.tabBarItem.image = UIImage(named: "icon-shopping")
        shoppingVC.tabBarItem.title = ""
//        shoppingVC.tabBarItem.selectedImage = UIImage(named: "icon-shopping")
        
        
        viewControllers = [
            navFridgeController,
            addVC,
            navShoppingController
        ]
    }
    
    //MARK: UITabbar Delegate
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController.isKind(of: ChooseCategoryCollectionViewController.self) {
            let vc =  ChooseCategoryCollectionViewController()
            let addNVC = UINavigationController(rootViewController: vc)
            
//            vc.modalPresentationStyle = .overFullScreen
            self.present(addNVC, animated: true, completion: nil)
            return false
        }
        return true
    }
//
//    fileprivate func createViewController(viewController: UIViewController, title: String, imageName: String, height: CGFloat = 49) -> UIViewController {
//
////        viewController.view.backgroundColor = .white
////        viewController.navigationItem.title = title
//        let navController = UINavigationController(rootViewController: viewController)
//
////        navController.navigationBar.prefersLargeTitles = true
////        navController.navigationBar.barTintColor = .eggYellow
////        navController.navigationBar.isTranslucent = false
////        navController.tabBarItem.badgeColor = .eggYellow
//        navController.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//        navController.navigationBar.shadowImage = UIImage()
//        navController.tabBarItem.title = title
//        navController.tabBarItem.image = UIImage(named: imageName)
//        navController.navigationController?.tabBarController?.tabBar.barTintColor = UIColor.red
//        return navController
//    }
    


}

//extension UITabBar {
//
//    override open func sizeThatFits(_ size: CGSize) -> CGSize {
//        super.sizeThatFits(size)
//        var sizeThatFits = super.sizeThatFits(size)
//        sizeThatFits.height = 49
//        return sizeThatFits
//    }
//}
