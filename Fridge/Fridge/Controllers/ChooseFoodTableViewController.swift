//
//  ChooseFoodTableViewController.swift
//  Fridge
//
//  Created by 酒井綾菜 on 2019-06-05.
//  Copyright © 2019 Ayana Sakai. All rights reserved.
//

import UIKit

class ChooseFoodTableViewController: UITableViewController {
    
    private let reuseIdentifier = "chooseFoodCell"
    
    let searchController = UISearchController(searchResultsController: nil)
    
    struct Objects {
        var sectionName : String!
        var sectionObjects : [String]!
    }
    
    var objectArray = [Objects]()
    var categoryName: String!
    
    var everyFoods = [String]()
    var filterFoods = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = ""
        tableView.backgroundColor = .bgGrey
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FoodTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        /* $0.0 - key, $0.1 - value */
        let foods = getFoodDictionary()
        let sotedFoods = foods.sorted(by: { $0.0 < $1.0})
        
        /* assign every foods in filterFoods */
        for (_, value) in sotedFoods {
            for i in value {
                everyFoods.append(i)
            }
        }

        for (key, value) in sotedFoods {
            objectArray.append(Objects(sectionName: key, sectionObjects: value))
        }
        
        setupRightAddButton()
        setupSearchBar()
    }
    
    // MARK: - helper methods
    
    private func getFoodDictionary() -> [String : [String]]{
        switch categoryName {
        case "Vegetable":
            return vagetableDictionary
        case "Fruit":
            return fruitsDictionary
        case "Meat":
            return meatDictionary
        case "Fish":
            return fishDictionary
        case "Dairy":
            return dairyDictionary
        case "Condiment":
            return condimentDictionary
        case "Bean":
            return beanDictionary
        case "Cereal":
            return cerealDictionary
        case "Seafood":
            return seafoodDictionary
        case "Seaweed":
            return seaweedDictionary
        case "Noodle/Pasta":
            return noodleDictionary
        case "Mushroom":
            return mushroomDictionary
        case "Drink":
            return drinkDictionary
        case "Others":
            return otherDictionary
        default:
            return otherDictionary
        }
    }
    
    private func setupRightAddButton() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonItemClicked))
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc func addButtonItemClicked() {
        let addNewFoodVC = AddNewFoodViewController()
        addNewFoodVC.categoryName = categoryName
//        let addNewFoodNVC = UINavigationController(rootViewController: addNewFoodVC)
//         self.present(addNewFoodVC, animated: true, completion: nil)
        navigationController?.pushViewController(addNewFoodVC, animated: true)
        
    }
    
    private func setupSearchBar() {
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Food"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        if isFiltering() {
            return 1
        }
        return objectArray.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filterFoods.count
        }
        return objectArray[section].sectionObjects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! FoodTableViewCell
        
        let food: String
        if isFiltering() {
            food = filterFoods[indexPath.row]
        } else {
            food = objectArray[indexPath.section].sectionObjects[indexPath.row]
        }
        
        cell.foodNameLabel.text = food
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return objectArray[section].sectionName
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let setExpirationVC = SetExpirationViewController()
        setExpirationVC.categoryName = categoryName
        if isFiltering() {
            setExpirationVC.foodName = filterFoods[indexPath.row]
        } else {
            setExpirationVC.foodName = objectArray[indexPath.section].sectionObjects[indexPath.row]
        }
        
        navigationController?.pushViewController(setExpirationVC, animated: true)
    }
    
    // MARK: - Private instance methods
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filterFoods = everyFoods.filter({( food : String) -> Bool in
            return food.lowercased().contains(searchText.lowercased())
        })

        tableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }

}

extension ChooseFoodTableViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
