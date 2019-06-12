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
        navigationController?.navigationBar.tintColor = .basicDarkBlue
        collectionView.backgroundColor = .bgGrey
        navigationItem.title = "Fridge"
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.basicDarkBlue,
             NSAttributedString.Key.font: UIFont.heavyFont(ofSize: 21)]
        
        collectionView.register(UsebyCardCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        collectionView.contentInset = UIEdgeInsets(top: 45, left: 0, bottom: 0, right: 0)
        
        getDataFromFirestore()
    }
    
    // MARK: - helper methods
    
    @objc func editButtonItemClicked() {
        print("Click editProduct")
    }
    
    @objc func addButtonItemClicked() {
        let chooseCategoryVC = ChooseCategoryCollectionViewController()
        navigationController?.pushViewController(chooseCategoryVC, animated: true)
    }

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
                    let notification = document.get("notification") as? Bool ?? false
                    let quantity = document.get("quantity") as? Int ?? 1
                    let usebyDateTimestamp = document.get("usebyDate") as? Timestamp ?? Timestamp()
                    let date = usebyDateTimestamp.dateValue()
                    
                    self.foodItems.append(FoodItem(id: docId, category: category, foodName: foodName, notification: notification, quantity: quantity, usebyDate: date))
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
        default:
            return UIImage(imageLiteralResourceName: "fish")
        }
    }
    
    // MARK: - Table view data source

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foodItems.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! UsebyCardCollectionViewCell
        cell.nameLabel.text = foodItems[indexPath.row].foodName
        if foodItems[indexPath.row].quantity > 1 {
            let quantStr = String(foodItems[indexPath.row].quantity)
            cell.quantityLabel.text = quantStr
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM.dd.yyyy"
        cell.usebyDetailDateLbel.text = dateFormatter.string(from: foodItems[indexPath.row].usebyDate)
        cell.imageView.image = setCategoryImage(category: foodItems[indexPath.row].category)
        
        let dateRangeStart = Date()
        let dateRangeEnd = foodItems[indexPath.row].usebyDate
        let components = Calendar.current.dateComponents([.day], from: dateRangeStart, to: dateRangeEnd)
//        print("difference is \(components.month ?? 0) months and \(components.weekOfYear ?? 0) weeks and \(components.day ?? 0)")
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
        
    }
    
    // MARK: - Table view layout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - padding * 2, height: 100)
    }
    
    let spacing: CGFloat = 15
    let padding: CGFloat = 15
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: spacing, left: padding, bottom: spacing, right: padding)
    }

}
