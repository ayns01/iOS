//
//  DetailViewController.swift
//  Fridge
//
//  Created by 酒井綾菜 on 2019-06-11.
//  Copyright © 2019 Ayana Sakai. All rights reserved.
//

import UIKit
import Firebase

class DetailViewController: UIViewController {
    
    var docId: String!
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let categoryNameLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = .regularFont(ofSize: 16)
        lb.textColor = .basicDarkBlue
        return lb
    }()
    
    let foodNameLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = .boldFont(ofSize: 20)
        lb.textColor = .basicDarkBlue
        return lb
    }()
    
    let usebydateTitleLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = .regularFont(ofSize: 16)
        lb.text = "Use by Date"
        lb.textColor = .basicDarkBlue
        return lb
    }()
    
    let usebyDatePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.backgroundColor = .white
        picker.contentMode = .center
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    let quantityTitleLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = .regularFont(ofSize: 16)
        lb.text = "Quantity"
        lb.textColor = .basicDarkBlue
        return lb
    }()
    
    let minusButt: UIButton = {
        let icon = UIImage(named: "minus-50")
        let butt = UIButton()
        butt.setImage(icon, for: .normal)
        return butt
    }()
    
    let quantityLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = .boldFont(ofSize: 18)
        lb.textColor = .basicDarkBlue
        return lb
    }()
    
    let plusButt: UIButton = {
        let icon = UIImage(named: "plus-50")
        let butt = UIButton()
        butt.setImage(icon, for: .normal)
        return butt
    }()
    
    let deleteButton: UIButton = {
        let butt = UIButton(type: .system)
        butt.translatesAutoresizingMaskIntoConstraints = false
        butt.setTitle("  DELETE", for: .normal)
        butt.contentEdgeInsets = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0)
        butt.setTitleColor(.white, for: .normal)
        butt.titleLabel?.font = .regularFont(ofSize: 15)
        butt.backgroundColor = .firstColor
        butt.layer.cornerRadius = 20
        return butt
    }()
    
    let saveButton: UIButton = {
        let butt = UIButton(type: .system)
        butt.translatesAutoresizingMaskIntoConstraints = false
        butt.setTitle("  SAVE", for: .normal)
        butt.contentEdgeInsets = UIEdgeInsets(top: 0, left: 41, bottom: 0, right: 0)
        butt.setTitleColor(.white, for: .normal)
        butt.titleLabel?.font = .regularFont(ofSize: 15)
        butt.backgroundColor = .secondColor
        butt.layer.cornerRadius = 20
        return butt
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        setUpUI()
        
        minusButt.addTarget(self, action: #selector(minusQuantity), for: .touchUpInside)
        plusButt.addTarget(self, action: #selector(plusQuantity), for: .touchUpInside)
        
        deleteButton.addTarget(self, action: #selector(deleteDocument), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(overrideDocument), for: .touchUpInside)
    }
    
    @objc func deleteDocument() {
        let db = Firestore.firestore()
        db.collection("usebyInfo").document(docId).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func overrideDocument() {
        let categoryName = categoryNameLabel.text ?? ""
        let foodName = foodNameLabel.text ?? ""
        let usebyDate = usebyDatePicker.date
        let quantStr = quantityLabel.text ?? "1"
        let quantity = Int(quantStr) ?? 1
        
        let db = Firestore.firestore()
        db.collection("usebyInfo").document(docId).setData([
            "category": categoryName,
            "foodName": foodName,
            "usebyDate": usebyDate,
            "quantity": quantity
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func minusQuantity() {
        
        let quantStr = quantityLabel.text ?? "1"
        var quant = Int(quantStr) ?? 1
        if quant <= 1 {
            return
        }else {
            quant -= 1
        }
        quantityLabel.text = String(quant)
    }
    
    @objc func plusQuantity() {
        
        let quantStr = quantityLabel.text ?? "1"
        var quant = Int(quantStr) ?? 1
        if quant > 100 {
            return
        }else {
            quant += 1
        }
        quantityLabel.text = String(quant)
    }
    
    private func setUpUI() {
        
        let hCategoryStackView = UIStackView(arrangedSubviews: [imageView, categoryNameLabel])
        hCategoryStackView.translatesAutoresizingMaskIntoConstraints = false
        hCategoryStackView.distribution = .fillProportionally
        hCategoryStackView.axis = .horizontal
        hCategoryStackView.spacing = 6
        view.addSubview(hCategoryStackView)
        hCategoryStackView.anchors(topAnchor: view.safeAreaLayoutGuide.topAnchor, leadingAnchor: view.leadingAnchor, trailingAnchor: nil, bottomAnchor: nil, padding: .init(top: 35, left: 15, bottom: 0, right: 0))
        
        view.addSubview(foodNameLabel)
        foodNameLabel.anchors(topAnchor: hCategoryStackView.bottomAnchor, leadingAnchor: view.leadingAnchor, trailingAnchor: nil, bottomAnchor: nil, padding: .init(top: 10, left: 15, bottom: 0, right: 0))
        
        let divider = UIView(frame: CGRect(x:0, y:  66, width: view.frame.width, height: 1.0))
        divider.backgroundColor = UIColor.lightGray
        hCategoryStackView.addSubview(divider)
        
        view.addSubview(usebydateTitleLabel)
        usebydateTitleLabel.anchors(topAnchor: divider.bottomAnchor, leadingAnchor: view.leadingAnchor, trailingAnchor: nil, bottomAnchor: nil, padding: .init(top: 35, left: 15, bottom: 0, right: 0))
        
        view.addSubview(usebyDatePicker)
        usebyDatePicker.anchors(topAnchor: usebydateTitleLabel.bottomAnchor, leadingAnchor: view.leadingAnchor, trailingAnchor: view.trailingAnchor, bottomAnchor: nil, padding: .init(top: 1, left: 0, bottom: 0, right: 0))
        
        view.addSubview(quantityTitleLabel)
        quantityTitleLabel.anchors(topAnchor: usebyDatePicker.bottomAnchor, leadingAnchor: view.leadingAnchor, trailingAnchor: nil, bottomAnchor: nil, padding: .init(top: 30, left: 15, bottom: 0, right: 0))
        
        let hQuantityStackView = UIStackView(arrangedSubviews: [minusButt, quantityLabel, plusButt])
        hQuantityStackView.translatesAutoresizingMaskIntoConstraints = false
        hQuantityStackView.distribution = .fillProportionally
        hQuantityStackView.axis = .horizontal
        hQuantityStackView.spacing = 10
        view.addSubview(hQuantityStackView)
        hQuantityStackView.anchors(topAnchor: usebyDatePicker.bottomAnchor, leadingAnchor: nil, trailingAnchor: view.trailingAnchor, bottomAnchor: nil, padding: .init(top: 30, left: 0, bottom: 0, right: 15))
        
        deleteButton.leftImage(image: #imageLiteral(resourceName: "icon-trash-white"), renderMode: .alwaysOriginal)
        view.addSubview(deleteButton)
        deleteButton.widthAnchor.constraint(equalToConstant: (view.frame.width / 2) - (25 + 12)).isActive = true
        deleteButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        deleteButton.anchors(topAnchor: hQuantityStackView.bottomAnchor, leadingAnchor: view.leadingAnchor, trailingAnchor: nil, bottomAnchor: nil, padding: .init(top: 45, left: 25, bottom: 0, right: 0))
        
        saveButton.leftImage(image: #imageLiteral(resourceName: "icon-save-white"), renderMode: .alwaysOriginal)
        view.addSubview(saveButton)
        saveButton.widthAnchor.constraint(equalToConstant: (view.frame.width / 2) - (25 + 12)).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        saveButton.anchors(topAnchor: hQuantityStackView.bottomAnchor, leadingAnchor: nil, trailingAnchor: view.trailingAnchor, bottomAnchor: nil, padding: .init(top: 45, left: 0, bottom: 0, right: 25))
    }

}
