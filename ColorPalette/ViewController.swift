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
    
    private  var roundedValue: Float = 0
    
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
        
        setViewColor()
        
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
        
        self.hideKeyboard()
    }
    
    func setViewColor() {
        paletteView.backgroundColor = UIColor(
            red: CGFloat(redController.value),
            green: CGFloat(greenController.value),
            blue: CGFloat(blueController.value),
            alpha: 1.0
        )
    }
    
    @objc func donePressed(textField: UITextField) {
        view.endEditing(true)
        
        setDataFromTextField(textField: redColorTextField, controller: redController, textValue: redValue)
        setDataFromTextField(textField: greenColorTextField, controller: greenController, textValue: greenValue)
        setDataFromTextField(textField: blueColorTextField, controller: blueController, textValue: blueValue)
        
        setViewColor()
    }
    
    func setDataFromTextField(textField: UITextField, controller: UISlider, textValue: UILabel) {
        guard let inputData = textField.text, !inputData.isEmpty else { return }
        if let data = Float(inputData) {
            if data >= 0 && data <= 1 {
                controller.value = data
                textValue.text = String(data)
                textField.placeholder = String(data)
                textField.text = ""
            } else {
                showAlert(textField: textField)
            }
        } else {
            showAlert(textField: textField)
        }
    }
    
    @IBAction func changeRedValue() {
        roundedValue = roundf(redController.value * 100) / 100
        redValue.text = String(roundedValue)
        redColorTextField.placeholder = String(roundedValue)
        setViewColor()
    }
    
    @IBAction func changeGreenValue() {
        roundedValue = roundf(greenController.value * 100) / 100
        greenValue.text = String(roundedValue)
        greenColorTextField.placeholder = String(roundedValue)
        setViewColor()
    }
    
    @IBAction func changeBlueValue() {
        roundedValue = roundf(blueController.value * 100) / 100
        blueValue.text = String(roundedValue)
        blueColorTextField.placeholder = String(roundedValue)
        setViewColor()
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

extension ViewController {
    private func hideKeyboard() {
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(self.dismissKeyboard)
        )
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
        
    }
}
