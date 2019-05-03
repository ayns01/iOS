//
//  ViewController.swift
//  TipCalculator
//
//  Created by 酒井綾菜 on 2019-04-30.
//  Copyright © 2019 Ayana Sakai. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var billAmountTextField: UITextField! {
        didSet {
            billAmountTextField.delegate = self
        }
    }
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var calulateButt: UIButton!
    @IBOutlet weak var adjustTipPercentage: UISlider!
    
    @IBOutlet weak var tipPercentageTextField: UITextField! {
        didSet {
            tipPercentageTextField.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTipPercentage()
        
        NotificationCenter.default.addObserver(self, selector:  #selector(keyboardWillBeShown), name: UIResponder.keyboardWillShowNotification, object: nil)


        NotificationCenter.default.addObserver(self, selector:  #selector(keyboardWillBeHidden), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    fileprivate func updateTipPercentage() {
        let tipPercentage = String(Int(adjustTipPercentage.value))
        tipAmountLabel.text = tipPercentage
        
        let billStr = billAmountTextField.text ?? "0"
        let billResult = Double(billStr) ?? 0
        
        let tipStr = Int(adjustTipPercentage.value)
        let tipResult = Double(tipStr)
        
        let tipShouldPay = billResult + billResult * (tipResult * 0.01)
        
        totalAmountLabel.text = String(tipShouldPay)
        
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        updateTipPercentage()
    }
    
    
    @IBAction func clickCalculateButt(_ sender: UIButton) {
        let billStr = billAmountTextField.text ?? "0"
        let billResult = Double(billStr) ?? 0
        
        let tipStr = tipPercentageTextField.text ?? "0"
        let tipResult = Double(tipStr) ?? 0
        
        let tipShouldPay = billResult + billResult * (tipResult * 0.01)
        
        totalAmountLabel.text = String(tipShouldPay)
        
    }
    
    
    /// キーボードが表示時に画面をずらす。
    @objc func keyboardWillBeShown(_ notification: Notification?) {
        if billAmountTextField.isFirstResponder {
            return
        }
        guard let rect = (notification?.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue,
            let duration = notification?.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else { return }
        UIView.animate(withDuration: duration) {
            let transform = CGAffineTransform(translationX: 0, y: -(rect.size.height))
            self.view.transform = transform
        }
    }

    /// キーボードが降りたら画面を戻す
    @objc func keyboardWillBeHidden(_ notification: Notification?) {
        guard let duration = notification?.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? TimeInterval else { return }
        UIView.animate(withDuration: duration) {
            self.view.transform = CGAffineTransform.identity
        }
    }

}

