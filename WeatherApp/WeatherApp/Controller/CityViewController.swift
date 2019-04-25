//
//  CityViewController.swift
//  WeatherApp
//
//  Created by 酒井綾菜 on 2019-04-24.
//  Copyright © 2019 Ayana Sakai. All rights reserved.
//

import UIKit

class CityViewController: UIViewController {

    let goDetailsButt: UIButton = {
        let butt = UIButton(type: .system)
        butt.translatesAutoresizingMaskIntoConstraints = false
        butt.setTitle("Go to details", for: .normal)
        butt.layer.cornerRadius = 10.0
        butt.backgroundColor = UIColor.darkGray
        butt.addTarget(self, action: #selector(showDetailVC), for: .touchUpInside)
        
        return butt
    }()
    
    @objc private func showDetailVC() {
        let detailVC = DetailViewController()
        detailVC.city = city
        detailVC.view.backgroundColor = .cyan
        navigationController?.pushViewController(detailVC, animated: true)
        
    }
    
    
    var city: City! // dependency Injection
//    didSet {
//
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarItem = UITabBarItem(title: city.name, image: UIImage(named: city.icon), selectedImage: nil)
        
        navigationItem.title = city.name
        
        view.addSubview(goDetailsButt)
        
        NSLayoutConstraint.activate([
            goDetailsButt.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            goDetailsButt.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ])
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
