//
//  UsebyCardTableViewController.swift
//  Fridge
//
//  Created by 酒井綾菜 on 2019-05-29.
//  Copyright © 2019 Ayana Sakai. All rights reserved.
//

import UIKit
import Firebase

class UsebyCardCollectionViewController: BaseCollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let reuseIdentifier = "reuseIdentifier"
    var foodItems = [FoodItem]()
    var filterFoodItems = [FoodItem]()
    var isFiltering: Bool = false
    
    var scView:UIScrollView!
    let buttonPadding:CGFloat = 10
    var xOffset:CGFloat = 10
    var categoryButtons = [UIButton]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .secondColor
        collectionView.backgroundColor = .bgGrey
        navigationItem.title = "Fridge"
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.basicDarkBlue,
             NSAttributedString.Key.font: UIFont.heavyFont(ofSize: 21)]
        
        collectionView.register(UsebyCardCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        collectionView.contentInset = UIEdgeInsets(top: 45, left: 0, bottom: 0, right: 0)
        
        setScrollButtons()
        
        getDataFromFirestore()
    }
    
    func setScrollButtons() {
        scView = UIScrollView(frame: CGRect(x: 0, y: 90, width: view.bounds.width, height: 50))
        view.addSubview(scView)
        scView.translatesAutoresizingMaskIntoConstraints = false
        for i in 0..<categories.count {
            let button = UIButton()
            categoryButtons.append(button)
            button.backgroundColor = UIColor.white
            button.tag = i
            button.setTitle("\(categories[i])", for: .normal)
            button.setTitleColor(.basicDarkBlue, for: .normal)
            button.titleLabel?.font = .regularFont(ofSize: 14)
            button.frame = CGRect(x: xOffset, y: CGFloat(buttonPadding), width: 90, height: 30)
            button.layer.cornerRadius = 10
            xOffset = xOffset + CGFloat(buttonPadding) + button.frame.size.width
            scView.addSubview(button)
            button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        }
        categoryButtons[0].backgroundColor = .secondColor
        scView.contentSize = CGSize(width: xOffset, height: scView.frame.height)
    }
    
    @objc func buttonPressed(sender: UIButton!) {
        
        filterFoodItems.removeAll()
        
        for i in 0..<categories.count {
            categoryButtons[i].backgroundColor = .white
            categoryButtons[sender.tag].backgroundColor = .secondColor
        }
        if categories[sender.tag] == "All" {
            isFiltering = false
            collectionView.reloadData()
        }else {
            isFiltering = true
            filterContentForCategoryButton(categories[sender.tag])
        }
    }
    
    // MARK: - helper methods

    private func getDataFromFirestore() {
        let db = Firestore.firestore()
        db.collection("usebyInfo").addSnapshotListener { (snapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                self.foodItems.removeAll()
                for document in snapshot!.documents {
                    let docId = document.documentID
                    let category = document.get("category") as? String ?? ""
                    let foodName = document.get("foodName") as? String ?? ""
                    let quantity = document.get("quantity") as? Int ?? 1
                    let usebyDateTimestamp = document.get("usebyDate") as? Timestamp ?? Timestamp()
                    let date = usebyDateTimestamp.dateValue()
                    
                    self.foodItems.append(FoodItem(id: docId, category: category, foodName: foodName, quantity: quantity, usebyDate: date))
                }
                
                self.foodItems.sort(by: { $0.usebyDate.compare($1.usebyDate) == .orderedAscending })
                
                self.collectionView.reloadData()
            }
        }
    }
    
    private func setCategoryImage(category: String) -> UIImage {
        switch category {
        case "Vegetable":
            return vegetableImage
        case "Fruit":
            return fruitImage
        case "Meat":
            return meatImage
        case "Fish":
            return fishImage
        case "Dairy":
            return dairyImage
        case "Condiment":
            return condimentImage
        case "Bean":
            return beanImage
        case "Cereal":
            return cerealImage
        case "Seafood":
            return seafoodImage
        case "Seaweed":
            return seaweedImage
        case "Mushroom":
            return mushroomImage
        case "Noodle/Pasta":
            return noodleImage
        case "Drink":
            return drinkImage
        default:
            return fishImage
        }
    }
    
    // MARK: - Table view data source

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (self.foodItems.count == 0) {
            self.collectionView.setEmptyMessage("Keep your fridge fresh !")
        } else {
            self.collectionView.restore()
        }
        
        if isFiltering {
            return filterFoodItems.count
        }        
        return foodItems.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! UsebyCardCollectionViewCell
        
        let foodCategory: String
        if isFiltering {
            foodCategory = filterFoodItems[indexPath.row].category
        } else {
            foodCategory = foodItems[indexPath.row].category
        }
        cell.imageView.image = setCategoryImage(category: foodCategory)
        
        let foodName: String
        if isFiltering {
            foodName = filterFoodItems[indexPath.row].foodName
        } else {
            foodName = foodItems[indexPath.row].foodName
        }
        cell.nameLabel.text = foodName
        
        let foodQuantity: String
        if isFiltering {
                foodQuantity = String(filterFoodItems[indexPath.row].quantity)
        } else {
                foodQuantity = String(foodItems[indexPath.row].quantity)
        }
        cell.quantityLabel.text = foodQuantity
        
        let foodDate: Date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM.dd.yyyy"
        if isFiltering {
            foodDate = filterFoodItems[indexPath.row].usebyDate
        } else {
            foodDate = foodItems[indexPath.row].usebyDate
        }
        cell.usebyDetailDateLabel.text = dateFormatter.string(from: foodDate)
        
        let dateRangeStart = Date()
        let components = Calendar.current.dateComponents([.day], from: dateRangeStart, to: foodDate)

        cell.expirationCountDateLabel.text = "\(components.day ?? 0) days"
        let day = components.day ?? 0
        if day > 3 {
            cell.expirationCountDateLabel.font = .regularFont(ofSize: 15)
            cell.expirationCountDateLabel.textColor = UIColor.darkGray
        }else if (-1 < day) && (day < 3)  {
            cell.expirationCountDateLabel.font = .boldFont(ofSize: 15)
            cell.expirationCountDateLabel.textColor = UIColor.tomatoRed
        }else {
            cell.expirationCountDateLabel.font = .boldFont(ofSize: 15)
            cell.expirationCountDateLabel.textColor = .doraemonBlue
        }
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        
        let foodCategory: String
        if isFiltering {
            foodCategory = filterFoodItems[indexPath.row].category
        } else {
            foodCategory = foodItems[indexPath.row].category
        }
        detailVC.categoryNameLabel.text = foodCategory
        detailVC.imageView.image = setCategoryImage(category: foodCategory)
        
        let foodName: String
        if isFiltering {
            foodName = filterFoodItems[indexPath.row].foodName
        } else {
            foodName = foodItems[indexPath.row].foodName
        }
        detailVC.foodNameLabel.text = foodName
        
        let foodDate: Date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM.dd.yyyy"
        if isFiltering {
            foodDate = filterFoodItems[indexPath.row].usebyDate
        } else {
            foodDate = foodItems[indexPath.row].usebyDate
        }
        let dateStr = dateFormatter.string(from: foodDate)
        let date = dateFormatter.date(from: dateStr) ?? Date()
        detailVC.usebyDatePicker.date = date
        
        let foodQuantity: String
        if isFiltering {
            foodQuantity = String(filterFoodItems[indexPath.row].quantity)
        } else {
            foodQuantity = String(foodItems[indexPath.row].quantity)
        }
        detailVC.quantityLabel.text = String(foodQuantity)
        
        let foodId: String
        if isFiltering {
            foodId = String(filterFoodItems[indexPath.row].id)
        } else {
            foodId = String(foodItems[indexPath.row].id)
        }
        detailVC.docId = foodId
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    // MARK: - Table view layout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - padding * 2, height: 100)
    }
    
    let spacing: CGFloat = 16
    let padding: CGFloat = 15
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: spacing, left: padding, bottom: spacing, right: padding)
    }
    
    // MARK: - Helper methods
    
    func filterContentForCategoryButton(_ category: String) {
        let db = Firestore.firestore()
        db.collection("usebyInfo").whereField("category", isEqualTo: category)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        let docId = document.documentID
                        let category = document.get("category") as? String ?? ""
                        let foodName = document.get("foodName") as? String ?? ""
                        let quantity = document.get("quantity") as? Int ?? 1
                        let usebyDateTimestamp = document.get("usebyDate") as? Timestamp ?? Timestamp()
                        let date = usebyDateTimestamp.dateValue()
                        self.filterFoodItems.append(FoodItem(id: docId, category: category, foodName: foodName, quantity: quantity, usebyDate: date))
                        
                    }
                    
                    self.collectionView.reloadData()
                }
        }
    }

}
