//
//  SetExpirationViewController.swift
//  Fridge
//
//  Created by 酒井綾菜 on 2019-06-05.
//  Copyright © 2019 Ayana Sakai. All rights reserved.
//

import UIKit
import Firebase

class SetExpirationViewController: UIViewController {
    
    var categoryName: String!
    var foodName: String!
    
    let categoryNameLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = .boldFont(ofSize: 16)
        lb.textColor = .basicDarkBlue
        return lb
    }()
    
    let foodNameLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = .regularFont(ofSize: 20)
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
        lb.font = .regularFont(ofSize: 18)
        lb.text = "1"
        lb.textColor = .basicDarkBlue
        return lb
    }()
    
    let plusButt: UIButton = {
        let icon = UIImage(named: "plus-50")
        let butt = UIButton()
        butt.setImage(icon, for: .normal)
        return butt
    }()
    
    let okButton: UIButton = {
        let butt = UIButton(type: .system)
        butt.setTitle("OK", for: .normal)
        butt.setTitleColor(.basicDarkBlue, for: .normal)
        butt.titleLabel?.font = .regularFont(ofSize: 20)
        butt.backgroundColor = .firstColor
        butt.widthAnchor.constraint(equalToConstant: 80).isActive = true
        butt.heightAnchor.constraint(equalToConstant: 44).isActive = true
        butt.layer.cornerRadius = 20
        return butt
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bgGrey
        
        categoryNameLabel.text = categoryName
        foodNameLabel.text = foodName
        
        setUpUI()
        
        minusButt.addTarget(self, action: #selector(minusQuantity), for: .touchUpInside)
        plusButt.addTarget(self, action: #selector(plusQuantity), for: .touchUpInside)
        
        okButton.addTarget(self, action: #selector(saveData), for: .touchUpInside)
        
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
    
    @objc func saveData() {

        let date = usebyDatePicker.date
        let quantStr = quantityLabel.text ?? "1"
        let quant = Int(quantStr) ?? 1
        
        sendDataToFireStore(categoryName: categoryName, foodName: foodName, quantity: quant, usebyDate: date)
        
        self.navigationController?.popToRootViewController(animated: true)
    }

    private func sendDataToFireStore(categoryName: String, foodName: String, quantity: Int, usebyDate: Date) {

        /* Add a new document with a generated ID */
        var ref: DocumentReference? = nil
        let db = Firestore.firestore()
        ref = db.collection("usebyInfo").addDocument(data: [
            "category": categoryName,
            "foodName": foodName,
            "usebyDate": usebyDate,
            "quantity": quantity
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }

    }
    
    private func setUpUI() {
        let vFoodStackView = UIStackView(arrangedSubviews: [categoryNameLabel, foodNameLabel])
        vFoodStackView.translatesAutoresizingMaskIntoConstraints = false
        vFoodStackView.distribution = .fillProportionally
        vFoodStackView.axis = .vertical
        vFoodStackView.spacing = 0
        view.addSubview(vFoodStackView)
        vFoodStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        vFoodStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 35).isActive = true
        
        view.addSubview(usebydateTitleLabel)
        usebydateTitleLabel.anchors(topAnchor: vFoodStackView.bottomAnchor, leadingAnchor: view.leadingAnchor, trailingAnchor: nil, bottomAnchor: nil, padding: .init(top: 35, left: 15, bottom: 0, right: 0))
        
        view.addSubview(usebyDatePicker)
        usebyDatePicker.anchors(topAnchor: usebydateTitleLabel.bottomAnchor, leadingAnchor: view.leadingAnchor, trailingAnchor: view.trailingAnchor, bottomAnchor: nil, padding: .init(top: 5, left: 0, bottom: 0, right: 0))
        
        view.addSubview(quantityTitleLabel)
        quantityTitleLabel.anchors(topAnchor: usebyDatePicker.bottomAnchor, leadingAnchor: view.leadingAnchor, trailingAnchor: nil, bottomAnchor: nil, padding: .init(top: 35, left: 15, bottom: 0, right: 0))
        
        let hQuantityStackView = UIStackView(arrangedSubviews: [minusButt, quantityLabel, plusButt])
        hQuantityStackView.translatesAutoresizingMaskIntoConstraints = false
        hQuantityStackView.distribution = .fillProportionally
        hQuantityStackView.axis = .horizontal
        hQuantityStackView.spacing = 10
        view.addSubview(hQuantityStackView)
        hQuantityStackView.anchors(topAnchor: usebyDatePicker.bottomAnchor, leadingAnchor: nil, trailingAnchor: view.trailingAnchor, bottomAnchor: nil, padding: .init(top: 30, left: 0, bottom: 0, right: 15))
        
        view.addSubview(okButton)
        okButton.anchors(topAnchor: nil, leadingAnchor: view.leadingAnchor, trailingAnchor: view.trailingAnchor, bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor, padding: .init(top: 0, left: 35, bottom: 85, right: 35))
    }

}
