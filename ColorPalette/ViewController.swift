//
//  ViewController.swift
//  ColorPalette
//
//  Created by Viktor on 25/07/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var paletteView: UIView!
    
    @IBOutlet var redValue: UILabel!
    @IBOutlet var greenValue: UILabel!
    @IBOutlet var blueValue: UILabel!
    
    @IBOutlet var redController: UISlider!
    @IBOutlet var greenController: UISlider!
    @IBOutlet var blueController: UISlider!
    
    @IBOutlet var redColorTextField: UITextField!
    @IBOutlet var greenColorTextField: UITextField!
    @IBOutlet var blueColorTextField: UITextField!
    
    var roundedRedValue: Float = 0
    var roundedGreenValue: Float = 0
    var roundedBlueValue: Float = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.redColorTextField.delegate = self
        self.greenColorTextField.delegate = self
        self.blueColorTextField.delegate = self
        
        redController.value = 0
        greenController.value = 0
        blueController.value = 0
        
        redValue.text = String(redController.value)
        greenValue.text = String(greenController.value)
        blueValue.text = String(blueController.value)
        
        redColorTextField.placeholder = String(redController.value)
        greenColorTextField.placeholder = String(greenController.value)
        blueColorTextField.placeholder = String(blueController.value)
        
        
        redController.minimumTrackTintColor = .red
        greenController.minimumTrackTintColor = .green
        blueController.minimumTrackTintColor = .blue
        
        paletteView.layer.cornerRadius = 15
        
        setViewColor(
            view: paletteView,
            red: redController.value,
            green: greenController.value,
            blue: blueController.value)
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let indent = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                     target: nil,
                                     action: nil
        )
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
                                         target: self,
                                         action: #selector(self.donePressed)
        )
        
        toolBar.setItems([indent, doneButton], animated: false)
        
        redColorTextField.inputAccessoryView = toolBar
        greenColorTextField.inputAccessoryView = toolBar
        blueColorTextField.inputAccessoryView = toolBar
    }
    
    @objc func donePressed(textField: UITextField) {
        view.endEditing(true)
    }


    @IBAction func changeRedValue() {
        roundedRedValue = roundf(redController.value * 100) / 100
        redValue.text = String(roundedRedValue)
        redColorTextField.placeholder = String(roundedRedValue)
        setViewColor(
            view: paletteView,
            red: roundedRedValue,
            green: roundedGreenValue,
            blue: roundedBlueValue)
    }
    
    @IBAction func changeGreenValue() {
        roundedGreenValue = roundf(greenController.value * 100) / 100
        greenValue.text = String(roundedGreenValue)
        greenColorTextField.placeholder = String(roundedGreenValue)
        setViewColor(
            view: paletteView,
            red: roundedRedValue,
            green: roundedGreenValue,
            blue: roundedBlueValue)
    }
    
    @IBAction func changeBlueValue() {
        roundedBlueValue = roundf(blueController.value * 100) / 100
        blueValue.text = String(roundedBlueValue)
        blueColorTextField.placeholder = String(roundedBlueValue)
        setViewColor(
            view: paletteView,
            red: roundedRedValue,
            green: roundedGreenValue,
            blue: roundedBlueValue)
    }
}

extension ViewController {
    private func setViewColor(view: UIView, red: Float, green: Float, blue: Float){
        paletteView.backgroundColor = UIColor(
            red: CGFloat(red),
            green: CGFloat(green),
            blue: CGFloat(blue),
            alpha: 1.0
        )
    }
}

extension ViewController {
    private func showAlert(textField: UITextField) {
        let alertWrongData = UIAlertController(
            title: "Wrong data!",
            message: "Enter data in range from 0 to 1",
            preferredStyle: .alert
        )
        
        let okAktion = UIAlertAction(
            title: "OK",
            style: .default) { _ in
                textField.text = ""
        }
        
        alertWrongData.addAction(okAktion)
        present(alertWrongData, animated: true)
    }
}

