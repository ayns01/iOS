//
//  ViewController.swift
//  ColorSelector
//
//  Created by Derrick Park on 2019-04-15.
//  Copyright © 2019 Derrick Park. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet var colorView: UIView!
  
  @IBOutlet var redSwitch: UISwitch!
  @IBOutlet var greenSwitch: UISwitch!
  @IBOutlet var blueSwitch: UISwitch!
  
  @IBOutlet var redSlider: UISlider!
  @IBOutlet var greenSlider: UISlider!
  @IBOutlet var blueSlider: UISlider!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    colorView.layer.borderWidth = 5.0
    colorView.layer.cornerRadius = 20
    colorView.layer.borderColor = UIColor.black.cgColor
    

    
    let defaults = UserDefaults.standard

    if defaults.object(forKey: "redSwitch") != nil {
        redSwitch.isOn = defaults.bool(forKey: "redSwitch")
    }
    if defaults.object(forKey: "greenSwitch") != nil {
        greenSwitch.isOn = defaults.bool(forKey: "greenSwitch")
    }
    if defaults.object(forKey: "blueSwitch") != nil {
        blueSwitch.isOn = defaults.bool(forKey: "blueSwitch")
    }
    
    if defaults.object(forKey: "redSlider") != nil {
        redSlider.value = defaults.float(forKey: "redSlider")
    }
    if defaults.object(forKey: "greenSlider") != nil {
        greenSlider.value = defaults.float(forKey: "greenSlider")
    }
    if defaults.object(forKey: "blueSlider") != nil {
        blueSlider.value = defaults.float(forKey: "blueSlider")
    }
    
    updateControls()
    updateColor()
    
  }

  fileprivate func updateColor() {
    
    var red: CGFloat = 0
    var green: CGFloat = 0
    var blue: CGFloat = 0
    
    let defaults = UserDefaults.standard
    
    if redSwitch.isOn {
      red = CGFloat(redSlider.value)
        defaults.set(red, forKey: "redSlider")
    }
    if greenSwitch.isOn {
      green = CGFloat(greenSlider.value)
        defaults.set(green, forKey: "greenSlider")
    }
    if blueSwitch.isOn {
      blue = CGFloat(blueSlider.value)
         defaults.set(blue, forKey: "blueSlider")
    }
    let bgColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    colorView.backgroundColor = bgColor
    
  }
  
  fileprivate func updateControls() {
    redSlider.isEnabled = redSwitch.isOn
    greenSlider.isEnabled = greenSwitch.isOn
    blueSlider.isEnabled = blueSwitch.isOn
  }
  
  @IBAction func switchChanged(_ sender: UISwitch) {
    updateControls()
    updateColor()
  }
    
  @IBAction func sliderChanged(_ sender: UISlider) {
    updateColor()
    
  }
  
  @IBAction func resetButtonTapped(_ sender: UIButton) {
    redSlider.value = 1
    greenSlider.value = 1
    blueSlider.value = 1
    
    redSwitch.isOn = false
    greenSwitch.isOn = false
    blueSwitch.isOn = false
    
    updateControls()
    updateColor()
  }
    
  
    @IBAction func saveSwitchState(_ sender: UISwitch) {
        let defaults = UserDefaults.standard
        
        if redSwitch.isOn {
            defaults.set(true, forKey: "redSwitch")
        }else {
             defaults.set(false, forKey: "redSwitch")
        }
        
        if greenSwitch.isOn {
            defaults.set(true, forKey: "greenSwitch")
        }else {
            defaults.set(false, forKey: "greenSwitch")
        }
        
        if blueSwitch.isOn {
            defaults.set(true, forKey: "blueSwitch")
        }else {
            defaults.set(false, forKey: "blueSwitch")
        }
    }
    
//    @IBAction func saveSliderState(_ sender: UISlider) {
//        let defaults = UserDefaults.standard
//
//        defaults.set(redSlider.value, forKey: "redSlider")
//        defaults.set(greenSlider.value, forKey: "greenSlider")
//        defaults.set(blueSlider.value, forKey: "blueSlider")
//
//    }
  
}

