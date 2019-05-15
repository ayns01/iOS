//
//  TodayCollectionViewController.swift
//  AppStore
//
//  Created by 酒井綾菜 on 2019-05-10.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit


class TodayCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    // MARK: Constant
    private let reuseIdentifier = "todayCell"

    // MARK: Life cycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        // TODO: hide navigationbar
        collectionView.backgroundColor = .white
        collectionView.register(TodayCollectionViewCell.self,
                                forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    // MARK: Initializers
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    // MARK: Collection view data source
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TodayCollectionViewCell
        
        return cell
    }
    
    
    // MARK: - UICollectionViewDelegate
    var startFrame: CGRect?
    var fullScreenController: UIViewController!
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // animation -> expand
        
        fullScreenController = UIViewController()
        fullScreenController.view.backgroundColor = .green
        
        fullScreenController.view.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        fullScreenController.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(removeTestView)))
        view.addSubview(fullScreenController.view)
        addChild(fullScreenController)

        
        // give me tha cell that I tapped
        guard let cell = collectionView.cellForItem(at: indexPath) else {
            return }
        
        // frame for animation -> absolugte coordinates of cell
        guard let startFrame =  cell.superview?.convert(cell.frame, to: nil) else {
            return }
        
        self.startFrame = startFrame
        fullScreenController.view.frame = startFrame
        fullScreenController.view.layer.cornerRadius = 16
        
        // dumping animation
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut,
            animations: {
            // what to animate
            self.fullScreenController.view.frame = self.view.frame
            self.tabBarController?.tabBar.transform = CGAffineTransform(translationX: 0, y: 100)
                
            self.navigationController?.setNavigationBarHidden(true, animated: true)
            
            
        }) { (_) in
            // what to do right after animation
            self.fullScreenController.removeFromParent()
        }
    }
    
    
    @objc func removeTestView(gesture: UITapGestureRecognizer) {
        // I wanna go back
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            
            gesture.view?.frame = self.startFrame ?? .zero
            self.tabBarController?.tabBar.transform = .identity
            self.navigationController?.setNavigationBarHidden(false, animated: true)
            
        }) { (_) in
            gesture.view?.removeFromSuperview()
        }
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.size.width - 64, height: 400)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 24
    }
    
    // give some space
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 12, left: 0, bottom: 12, right: 0)
    }
    
    

}
