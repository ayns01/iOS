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
    
    let foodGroupLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = .regularFont(ofSize: 16)
        lb.text = "Choose Food Group"
        lb.textColor = .basicDarkBlue
        return lb
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .bgGrey
        navigationItem.title = ""
        navigationController?.navigationBar.tintColor = .secondColor
//        self.navigationController?.navigationBar.titleTextAttributes =
//            [NSAttributedString.Key.foregroundColor: UIColor.basicDarkBlue,
//             NSAttributedString.Key.font: UIFont.regularFont(ofSize: 18)]
        
        view.addSubview(foodGroupLabel)
        foodGroupLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        foodGroupLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        

        self.collectionView!.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        collectionView.contentInset = UIEdgeInsets(top: 55, left: 0, bottom: 0, right: 0)
        
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
        cancelBtn.tintColor = .secondColor
        navigationItem.leftBarButtonItem = cancelBtn
    }
    
    @objc func cancelPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    private func bgColorOfCategoryCell(index: Int) -> CGColor {
        switch index {
        case 0:
            return vegetableColor.cgColor
        case 1:
            return fruitColor.cgColor
        case 2:
            return meatColor.cgColor
        case 3:
            return fishColor.cgColor
        case 4:
            return dairyColor.cgColor
        case 5:
            return condimentColor.cgColor
        case 6:
            return beanColor.cgColor
        case 7:
            return cerealColor.cgColor
        case 8:
            return seafoodColor.cgColor
        case 9:
            return seaweedColor.cgColor
        case 10:
            return noodleColor.cgColor
        case 11:
            return mushroomColor.cgColor
        case 12:
            return drinkColor.cgColor
        case 13:
            return othersColor.cgColor
        default:
            return UIColor.gray.cgColor
        }
    }
}
