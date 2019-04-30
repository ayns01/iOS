//
//  DetailsView.swift
//  WeatherApp
//
//  Created by 酒井綾菜 on 2019-04-26.
//  Copyright © 2019 Ayana Sakai. All rights reserved.
//

import UIKit

class DetailsView: UIView {

    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var summary: UILabel!
    
    func setupView(city: City) {
        self.country.text = city.flag
        self.city.text = city.name
        self.temp.text = "\(city.temp)"
        self.summary.text = city.summary
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
