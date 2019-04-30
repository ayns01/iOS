//
//  FirstTableViewController.swift
//  TableViewDemo
//
//  Created by 酒井綾菜 on 2019-04-26.
//  Copyright © 2019 Ayana Sakai. All rights reserved.
//

import UIKit

class FirstTableViewController: UITableViewController {

    var names:[String] = [
        "Derrick", "Tom", "Gui", "Kazuya", "Juan", "Hao-tse", "Paulo",
        "Scott", "Ayana", "Shota", "Masa", "Enrique", "Mihail", "Ozan",
        "Daisuke", "Danilo"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    // which cell you are trying to display
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NameCell
        cell.nameCell?.text = names[indexPath.row]
        return cell
    }
}
