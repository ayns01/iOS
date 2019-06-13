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
        
        getDataFromFirestore()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
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
                self.collectionView.reloadData()
            }
        }
    }
    
    private func setCategoryImage(category: String) -> UIImage {
        switch category {
        case "Vegetable":
            return UIImage(imageLiteralResourceName: "vegetable")
        case "Fruit":
            return UIImage(imageLiteralResourceName: "fruit")
        case "Meat":
            return UIImage(imageLiteralResourceName: "meat")
        case "Fish":
            return UIImage(imageLiteralResourceName: "fish")
        case "Dairy":
            return UIImage(imageLiteralResourceName: "dairy")
        case "Condiment":
            return UIImage(imageLiteralResourceName: "condiment")
        case "Bean":
            return UIImage(imageLiteralResourceName: "bean")
        case "Cereal":
            return UIImage(imageLiteralResourceName: "cereal")
        case "Seafood":
            return UIImage(imageLiteralResourceName: "seafood")
        case "Seaweed":
            return UIImage(imageLiteralResourceName: "seaweed")
        case "Mushroom":
            return UIImage(imageLiteralResourceName: "mushroom")
        case "Noodle/Pasta":
            return UIImage(imageLiteralResourceName: "noodle")
        case "Drink":
            return UIImage(imageLiteralResourceName: "drink")
        default:
            return UIImage(imageLiteralResourceName: "fish")
        }
    }
    
    // MARK: - Table view data source

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (self.foodItems.count == 0) {
            self.collectionView.setEmptyMessage("Keep your fridge fresh !")
        } else {
            self.collectionView.restore()
        }
        
        return foodItems.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! UsebyCardCollectionViewCell
        cell.nameLabel.text = foodItems[indexPath.row].foodName
        if foodItems[indexPath.row].quantity >= 1 {
            let quantStr = String(foodItems[indexPath.row].quantity)
            cell.quantityLabel.text = quantStr
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM.dd.yyyy"
        cell.usebyDetailDateLabel.text = dateFormatter.string(from: foodItems[indexPath.row].usebyDate)
        cell.imageView.image = setCategoryImage(category: foodItems[indexPath.row].category)
        
        let dateRangeStart = Date()
        let dateRangeEnd = foodItems[indexPath.row].usebyDate
        let components = Calendar.current.dateComponents([.day], from: dateRangeStart, to: dateRangeEnd)

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
        detailVC.categoryNameLabel.text = foodItems[indexPath.row].category
        detailVC.imageView.image = setCategoryImage(category: foodItems[indexPath.row].category)
        detailVC.foodNameLabel.text = foodItems[indexPath.row].foodName
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM.dd.yyyy"
        let dateStr = dateFormatter.string(from: foodItems[indexPath.row].usebyDate)
        let date = dateFormatter.date(from: dateStr) ?? Date()
        detailVC.usebyDatePicker.date = date
        detailVC.quantityLabel.text = String(foodItems[indexPath.row].quantity)
        detailVC.docId = foodItems[indexPath.row].id
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

}
