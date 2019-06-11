//
//  ChooseCategoryCollectionViewController.swift
//  Fridge
//
//  Created by 酒井綾菜 on 2019-06-04.
//  Copyright © 2019 Ayana Sakai. All rights reserved.
//

import UIKit

private let reuseIdentifier = "categoryCell"

class ChooseCategoryCollectionViewController: BaseCollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let categories: [String] = ["Vegetable", "Fruit", "Meat", "Fish", "Dairy", "Condiment", "Bean",
                                "Cereal", "Seafood", "Seaweed", "Noodle/Pasta", "Mushroom", "Drink", "Others"]

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .bgGrey
        navigationItem.title = "Category"
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.basicDarkBlue,
             NSAttributedString.Key.font: UIFont.mainFont(ofSize: 20)]

        self.collectionView!.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        setupNavigation()
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CategoryCollectionViewCell
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 12

        cell.layer.backgroundColor = bgColorOfCategoryCell(index: indexPath.row)
        cell.categoryNameLabel.text = categories[indexPath.row]
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let categoryName = categories[indexPath.row]
        
        let chooseFoodVC = ChooseFoodTableViewController()
        chooseFoodVC.categoryName = categoryName
        navigationController?.pushViewController(chooseFoodVC, animated: true)
    }
    
    
     // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let padding: CGFloat =  50
        let collectionViewSize = collectionView.frame.size.width - padding
        
        /* 2 columns */
        return CGSize(width: collectionViewSize/2, height: 70)
    }
    
    final let spacing: CGFloat = 12
    final let padding: CGFloat = 20
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: spacing, left: padding, bottom: spacing, right: padding)
    }
    
    fileprivate func setupNavigation() {
        let cancelBtn = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPressed))
        cancelBtn.tintColor = .basicDarkBlue
        navigationItem.leftBarButtonItem = cancelBtn
    }
    
    @objc func cancelPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    private func bgColorOfCategoryCell(index: Int) -> CGColor {
        switch index {
        case 0:
            let vegetable = UIColor(red: 146.0/255.0, green: 226.0/255.0, blue: 137.0/255.0, alpha: 1.0)
            return vegetable.cgColor
        case 1:
            let fruit = UIColor(red: 255.0/255.0, green: 171.0/255.0, blue: 25.0/255.0, alpha: 1.0)
            return fruit.cgColor
        case 2:
            let meat = UIColor(red: 241.0/255.0, green: 151.0/255.0, blue: 192.0/255.0, alpha: 1.0)
            return meat.cgColor
        case 3:
            let fish = UIColor(red: 184.0/255.0, green: 212.0/255.0, blue: 255.0/255.0, alpha: 1.0)
            return fish.cgColor
        case 4:
            let dairy = UIColor(red: 254.0/255.0, green: 246.0/255.0, blue: 91.0/255.0, alpha: 1.0)
            return dairy.cgColor
        case 5:
            let condiment = UIColor(red: 180.0/255.0, green: 159.0/255.0, blue: 220.0/255.0, alpha: 1.0)
            return condiment.cgColor
        case 6:
            let bean = UIColor(red: 187.0/255.0, green: 103.0/255.0, blue: 69.0/255.0, alpha: 1.0)
            return bean.cgColor
        case 7:
            let cereal = UIColor(red: 193.0/255.0, green: 186.0/255.0, blue: 93.0/255.0, alpha: 1.0)
            return cereal.cgColor
        case 8:
            let seafood = UIColor(red: 9.0/255.0, green: 173.0/255.0, blue: 199.0/255.0, alpha: 1.0)
            return seafood.cgColor
        case 9:
            let seaweed = UIColor(red: 71.0/255.0, green: 179.0/255.0, blue: 156.0/255.0, alpha: 1.0)
            return seaweed.cgColor
        case 10:
            let noodle = UIColor(red: 244.0/255.0, green: 80.0/255.0, blue: 77.0/255.0, alpha: 1.0)
            return noodle.cgColor
        case 11:
            let mushroom = UIColor(red: 218.0/255.0, green: 182.0/255.0, blue: 146.0/255.0, alpha: 1.0)
            return mushroom.cgColor
        case 12:
            let drink = UIColor(red: 244.0/255.0, green: 243.0/255.0, blue: 216.0/255.0, alpha: 1.0)
            return drink.cgColor
        case 13:
            let others = UIColor(red: 255.0/255.0, green: 220.0/255.0, blue: 222.0/255.0, alpha: 1.0)
            return others.cgColor
        default:
            return UIColor.gray.cgColor
        }
    }
}
