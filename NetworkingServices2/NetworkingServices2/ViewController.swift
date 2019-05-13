//
//  ViewController.swift
//  NetworkingServices2
//
//  Created by 酒井綾菜 on 2019-05-07.
//  Copyright © 2019 Ayana Sakai. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    private let reuseIdentifier = "repo"
    private var repos: [Repo] = [Repo]()
    private let refreshController = UIRefreshControl()
    private let usernames: [String] = ["ayns01", "b", "c", "d"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.refreshControl = refreshController
        refreshController.addTarget(self, action: #selector(refreshRepos), for: .valueChanged)
        // does not need to register if customizing UI tableviewcell
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        getRepositories(username: "ayns01")
    }
    
    @objc func refreshRepos() {
        let username = usernames.randomElement()
        navigationItem.title = username
//        getRepositories(username: username)
//        refreshController.endRefreshing()
    }
    
    private func getRepositories(username: String) {
        guard let url = URL(string: "https://api.github.com/users/\(username)/repos") else { return }
        let task = URLSession(configuration: .default).dataTask(with: url) { (data, res, err) in
            if let err = err {
                print("Error", err)
                return
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let repos = try decoder.decode([Repo].self, from: data)
                    self.repos = repos
                    
                    // update UI (main thread)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        
                        self.refreshController.endRefreshing()
                    }
                } catch {
                    debugPrint("Error", error)
                }
            }
        }
        task.resume()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) else {
            return UITableViewCell(style: .subtitle, reuseIdentifier: reuseIdentifier)
        }
        return cell
    }()
        
        cell.textLabel?.text = repos[indexPath.row].name
        cell.detailTextLabel?.text = repos[indexPath.row].created_at.description // need to assign String
        return cell
        
    }

    

}

