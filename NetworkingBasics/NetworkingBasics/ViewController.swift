//
//  ViewController.swift
//  NetworkingBasics
//
//  Created by 酒井綾菜 on 2019-05-07.
//  Copyright © 2019 Ayana Sakai. All rights reserved.
//

import UIKit

class ViewController: UIViewController, URLSessionDownloadDelegate {
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        
        // 5. update UI (main thread)
        do {
            let data = try Data(contentsOf: location)
            OperationQueue.main.addOperation {
                self.phoneImageView.image = UIImage(data: data)
            }
        } catch {
            print(error)
        }
        
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        let progress = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
        print(progress)
    }
    
    let phoneImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(phoneImageView)
        phoneImageView.matchParent()
        
        // 1. create an url object
        guard let url = URL(string: "http://imgur.com/zdwdenZ.png") else { return }
        
        // 2. create an URLSession object
        // let session = URLSession.shared // singleton object (basic configuration)
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        let task = session.downloadTask(with: url)
        
        // 4. resume! (by default, task -> suspended state)
        task.resume()
    }
    
}
