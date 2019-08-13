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
        
        setToolBar(textField: redColorTextField)
        setToolBar(textField: greenColorTextField)
        setToolBar(textField: blueColorTextField)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
        setColorInView(textField: redColorTextField, controller: redController, textValue: redValue)
        setColorInView(textField: greenColorTextField, controller: greenController, textValue: greenValue)
        setColorInView(textField: blueColorTextField, controller: blueController, textValue: blueValue)
    }
    
    @objc func donePressed(textField: UITextField) {
        view.endEditing(true)
        
        setColorInView(textField: redColorTextField, controller: redController, textValue: redValue)
        setColorInView(textField: greenColorTextField, controller: greenController, textValue: greenValue)
        setColorInView(textField: blueColorTextField, controller: blueController, textValue: blueValue)
    }
    
    func setColorInView(textField: UITextField, controller: UISlider, textValue: UILabel) {
        guard let inputData = textField.text, !inputData.isEmpty else {
            paletteView.backgroundColor = UIColor(
                red: CGFloat(redController.value),
                green: CGFloat(greenController.value),
                blue: CGFloat(blueController.value),
                alpha: 1.0
            )
            return
        }
        if let data = Float(inputData) {
            if data >= 0 && data <= 1 {
                controller.setValue(data, animated: true)
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
        setColorInView(textField: redColorTextField, controller: redController, textValue: redValue)
    }
    
    @IBAction func changeGreenValue() {
        roundedValue = roundf(greenController.value * 100) / 100
        greenValue.text = String(roundedValue)
        greenColorTextField.placeholder = String(roundedValue)
        setColorInView(textField: greenColorTextField, controller: greenController, textValue: greenValue)
    }
    
    @IBAction func changeBlueValue() {
        roundedValue = roundf(blueController.value * 100) / 100
        blueValue.text = String(roundedValue)
        blueColorTextField.placeholder = String(roundedValue)
        setColorInView(textField: blueColorTextField, controller: blueController, textValue: blueValue)
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
    
    
    private func setToolBar(textField: UITextField) {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let indent = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                     target: nil,
                                     action: nil )
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
                                         target: self,
                                         action: #selector(self.donePressed))
        
        toolBar.setItems([indent, doneButton], animated: false)
        
        textField.inputAccessoryView = toolBar
    }
    
}
