//
//  ViewController.swift
//  Assignment1Starter
//
//  Created by 酒井綾菜 on 2019-04-17.
//  Copyright © 2019 Ayana Sakai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // 1. ceate main green view
    let mainView: UIView = { // closure
        let v = UIView()
        // important  when setting constraints programatically
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .green
        return v
    }()
    
    let purpleBoxView: UIView = { // closure
        let v = UIView()
        // important  when setting constraints programatically
        v.frame = CGRect.zero
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .purple
        return v
    }()
    
    let orangeBoxView: UIView = { // closure
        let v = UIView()
        // important  when setting constraints programatically
        v.frame = CGRect.zero
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor(red: 1, green: 0.2784, blue: 0.0196, alpha: 1.0)
        return v
    }()
    
    let paleorange1BoxView: UIView = { // closure
        let v = UIView()
        // important  when setting constraints programatically
        v.heightAnchor.constraint(equalToConstant:30).isActive = true
        v.widthAnchor.constraint(equalToConstant:30).isActive = true
        v.backgroundColor = .orange
        return v
    }()
    
    let paleorange2BoxView: UIView = { // closure
        let v = UIView()
        // important  when setting constraints programatically
        v.heightAnchor.constraint(equalToConstant:30).isActive = true
        v.widthAnchor.constraint(equalToConstant:60).isActive = true
        v.backgroundColor = .orange
        return v
    }()
    
    let blueBox1View: UIView = { // closure
        let v = UIView()
        v.heightAnchor.constraint(equalToConstant:50).isActive = true
        v.widthAnchor.constraint(equalToConstant:50).isActive = true
        v.backgroundColor = .blue
        return v
    }()
    
    let blueBox2View: UIView = { // closure
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.heightAnchor.constraint(equalToConstant:50).isActive = true
        v.widthAnchor.constraint(equalToConstant:50).isActive = true
        v.backgroundColor = .blue
        return v
    }()
    
    let blueBox3View: UIView = { // closure
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.heightAnchor.constraint(equalToConstant:50).isActive = true
        v.widthAnchor.constraint(equalToConstant:50).isActive = true
        v.backgroundColor = .blue
        return v
    }()
    
    // 2. create 3 buttons
    let squareButt: UIButton = {
        let butt = UIButton(type: .system)
        butt.setTitle("Square", for: .normal)
        butt.translatesAutoresizingMaskIntoConstraints = false
        butt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        butt.addTarget(self, action: #selector(squareTapped), for: .touchUpInside)
        
        return butt
    }()
    
    let portraitButt: UIButton = {
        let butt = UIButton(type: .system)
        butt.setTitle("Portrait", for: .normal)
        butt.translatesAutoresizingMaskIntoConstraints = false
        butt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        butt.addTarget(self, action: #selector(portraitTapped), for: .touchUpInside)
        
        return butt
    }()
    
    let landscapeButt: UIButton = {
        let butt = UIButton(type: .system)
        butt.setTitle("Landscape", for: .normal)
        butt.translatesAutoresizingMaskIntoConstraints = false
        butt.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        butt.addTarget(self, action: #selector(landscapeTapped), for: .touchUpInside)
        
        return butt
    }()
    
    var widthAnchor: NSLayoutConstraint?
    var heightAnchor: NSLayoutConstraint?
    
    var widthPurpleAnchor: NSLayoutConstraint?
    var heightPurpleAnchor: NSLayoutConstraint?
    
    fileprivate func setupLayout() {
        // set constraints for mainView(x, y, w, h)
        mainView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mainView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        widthAnchor = mainView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7)
        widthAnchor?.isActive = true
        heightAnchor = mainView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7)
        heightAnchor?.isActive = true
        
        // 3. create a stackview
        let buttStackView = UIStackView(arrangedSubviews: [squareButt, portraitButt, landscapeButt])
        buttStackView.translatesAutoresizingMaskIntoConstraints = false
        buttStackView.axis = .horizontal
        buttStackView.distribution = .fillEqually
        buttStackView.alignment = .center
        view.addSubview(buttStackView)
        
        // 4. setup constraints for the stackView (pinned to left, right, bottom, give a height)
        NSLayoutConstraint.activate([
            buttStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            buttStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttStackView.widthAnchor.constraint(equalTo: view.widthAnchor),
            buttStackView.heightAnchor.constraint(equalToConstant: 50),
            ])
        
        purpleBoxView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -50).isActive = true
        purpleBoxView.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -50).isActive = true
        widthPurpleAnchor = purpleBoxView.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.6)
        widthPurpleAnchor?.isActive = true
        purpleBoxView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        orangeBoxView.bottomAnchor.constraint(equalTo: mainView.topAnchor, constant: 100).isActive = true
        orangeBoxView.rightAnchor.constraint(equalTo: mainView.rightAnchor, constant: -50).isActive = true
        orangeBoxView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        orangeBoxView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let paleorangeBoxStackView = UIStackView(arrangedSubviews: [paleorange1BoxView, paleorange2BoxView])
        paleorangeBoxStackView.translatesAutoresizingMaskIntoConstraints = false
        paleorangeBoxStackView.axis = .horizontal
        paleorangeBoxStackView.distribution = .fillEqually
        paleorangeBoxStackView.alignment = .center
        paleorangeBoxStackView.spacing = 10;
        view.addSubview(paleorangeBoxStackView)
        
        NSLayoutConstraint.activate([
            paleorangeBoxStackView.centerYAnchor.constraint(equalTo: orangeBoxView.centerYAnchor),
            paleorangeBoxStackView.centerXAnchor.constraint(equalTo: orangeBoxView.centerXAnchor),
            paleorangeBoxStackView.widthAnchor.constraint(equalTo: orangeBoxView.widthAnchor, multiplier: 0.9),
            paleorangeBoxStackView.heightAnchor.constraint(equalTo: orangeBoxView.heightAnchor, multiplier: 0.9),
            ])
        
        
        let blueBoxStackView = UIStackView(arrangedSubviews: [blueBox1View, blueBox2View, blueBox3View])
        blueBoxStackView.translatesAutoresizingMaskIntoConstraints = false
        blueBoxStackView.axis = .vertical
        blueBoxStackView.distribution = .fillEqually
        blueBoxStackView.alignment = .center
        blueBoxStackView.spacing = 30;
        view.addSubview(blueBoxStackView)
        
        NSLayoutConstraint.activate([
            blueBoxStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            blueBoxStackView.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
            blueBoxStackView.widthAnchor.constraint(equalToConstant: 50),
            blueBoxStackView.heightAnchor.constraint(equalToConstant: 210),
            ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(mainView)
        view.addSubview(purpleBoxView)
        view.addSubview(orangeBoxView)
        
        setupLayout()
    }
    
    @objc private func squareTapped() {
        // 5. animate mainView
        //    - change width constraint (w: 70% -> 80% w, h: 70% -> 80% h)
        view.layoutIfNeeded()
        
        UIView.animate(withDuration: 2.0) {
            // what you wanna animate
            self.widthAnchor?.isActive = false
            self.widthAnchor = self.mainView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9)
            self.widthAnchor?.isActive = true
            
            self.heightAnchor?.isActive = false
            self.heightAnchor = self.mainView.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9)
            self.heightAnchor?.isActive = true

            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func portraitTapped() {
        // 5. animate mainView
        //    - change width constraint (w: 70% -> 80% w, h: 70% -> 80% h)
        view.layoutIfNeeded()
        UIView.animate(withDuration: 2.0) {
            
            self.widthAnchor?.isActive = false
            self.widthAnchor = self.mainView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.4)
            self.widthAnchor?.isActive = true
            
            self.heightAnchor?.isActive = false
            self.heightAnchor = self.mainView.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9)
            self.heightAnchor?.isActive = true
            
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func landscapeTapped() {
        // 5. animate mainView
        //    - change width constraint (w: 70% -> 95% w, h: 70% -> 40% h)
        view.layoutIfNeeded()
        UIView.animate(withDuration: 2.0) {
            
            self.widthAnchor?.isActive = false
            self.widthAnchor = self.mainView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9)
            self.widthAnchor?.isActive = true
            
            self.heightAnchor?.isActive = false
            self.heightAnchor = self.mainView.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.4)
            self.heightAnchor?.isActive = true
            
            self.view.layoutIfNeeded()
        }
    }

}

