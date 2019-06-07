//
//  BaseCollectionViewController.swift
//  Fridge
//
//  Created by 酒井綾菜 on 2019-05-30.
//  Copyright © 2019 Ayana Sakai. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class BaseCollectionViewController: UICollectionViewController {
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
