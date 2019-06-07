//
//  UsebyCardTableViewController.swift
//  Fridge
//
//  Created by 酒井綾菜 on 2019-05-29.
//  Copyright © 2019 Ayana Sakai. All rights reserved.
//

import UIKit

class UsebyCardCollectionViewController: BaseCollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let reuseIdentifier = "reuseIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .basicDarkBlue
        collectionView.backgroundColor = .bgGrey
        navigationItem.title = "Fridge"
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.basicDarkBlue,
             NSAttributedString.Key.font: UIFont.mainFont(ofSize: 28)]
        
        collectionView.register(UsebyCardCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        
        setupLeftAddButton()
        setupRightAddButton()
    }
    
    // MARK: - helper methods
    
    private func setupLeftAddButton() {
        let addButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editButtonItemClicked))
        navigationItem.leftBarButtonItem = addButton
    }
    
    private func setupRightAddButton() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonItemClicked))
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc func editButtonItemClicked() {
        print("Click editProduct")
    }
    
    @objc func addButtonItemClicked() {
        let chooseCategoryVC = ChooseCategoryCollectionViewController()
//        chooseCategoryVC.delegate = self
        navigationController?.pushViewController(chooseCategoryVC, animated: true)
    }

    // MARK: - Table view data source

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! UsebyCardCollectionViewCell
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 8
        
        cell.layer.borderWidth = 2.0
        cell.layer.borderColor = UIColor.eggYellow.cgColor
        
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.layer.shadowOffset = CGSize(width: 15.0, height: 4.0)
        cell.layer.shadowRadius = 0.0
        cell.layer.shadowOpacity = 0.5
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.layer.cornerRadius).cgPath
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return .init(width: view.frame.width - padding * 2, height: 100)
    }
    
    final let spacing: CGFloat = 15
    final let padding: CGFloat = 15
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: spacing, left: padding, bottom: spacing, right: padding)
    }

}
