//
//  ViewController.swift
//  ColorPalette
//
//  Created by Viktor on 25/07/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

protocol ColorDelegate {
    func sendColor(color: UIColor)
}

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet var paletteView: UIView!
    
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    var color: UIColor!
    var delegate: ColorDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        
        redSlider.value = Float(color.redValue)
        greenSlider.value = Float(color.greenValue)
        blueSlider.value = Float(color.blueValue)
        
        paletteView.backgroundColor = color
        paletteView.layer.cornerRadius = 15
        
        redSlider.minimumTrackTintColor = .red
        greenSlider.minimumTrackTintColor = .green
        
        setColore()
        setValueForLabel()
        setValueForTextField()
        
        setToolBar(textField: redTextField)
        setToolBar(textField: greenTextField)
        setToolBar(textField: blueTextField)
        
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
    }
    
    
    @IBAction func doneButtonPressed() {
        color = UIColor(red: CGFloat(redSlider.value),
                        green: CGFloat(greenSlider.value),
                        blue: CGFloat(blueSlider.value),
                        alpha: 1)
        delegate?.sendColor(color: color)
        dismiss(animated: true, completion: nil)
    }
    
    private func setColore() {
        paletteView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1.0
        )
    }
    
    @IBAction func rgbSlaider(_ sender: UISlider) {
        switch sender.tag {
        case 0:
            redLabel.text = string(from: redSlider)
            redTextField.text = string(from: redSlider)
        case 1:
            greenLabel.text = string(from: greenSlider)
            greenTextField.text = string(from: greenSlider)
        case 2:
            blueLabel.text = string(from: blueSlider)
            blueTextField.text = string(from: blueSlider)
        default:
            break
        }
        
        setColore()
    }
    
    private func setValueForLabel() {
        redLabel.text = string(from: redSlider)
        greenLabel.text = string(from: greenSlider)
        blueLabel.text = string(from: blueSlider)
    }
    
    private func setValueForTextField() {
        redTextField.text = string(from: redSlider)
        greenTextField.text = string(from: greenSlider)
        blueTextField.text = string(from: blueSlider)
    }
    
    private func string(from slider: UISlider) -> String {
        return String(roundf(slider.value * 100) / 100)
    }
}

extension SettingsViewController: UITextFieldDelegate {
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    @objc func keyboardsDoneButtonPressed(textField: UITextField) {
        view.endEditing(true)
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let text = textField.text else { return }
        
        if let currentValue = Float(text) {
            switch textField.tag {
            case 0: redSlider.value = currentValue
            case 1: greenSlider.value = currentValue
            case 2: blueSlider.value = currentValue
            default: break }
            
            setColore()
            setValueForLabel()
        } else {
            showAlert()
            
        }
    }
}

extension SettingsViewController {
    private func showAlert() {
        let alertWrongData = UIAlertController(
            title: "Wrong data!",
            message: "Enter data in range from 0 to 1",
            preferredStyle: .alert
        )
        let okAktion = UIAlertAction(title: "OK", style: .default)
        alertWrongData.addAction(okAktion)
        present(alertWrongData, animated: true)
    }
    
    func setToolBar(textField: UITextField) {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let indent = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                     target: nil,
                                     action: nil )
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
                                         target: self,
                                         action: #selector(self.keyboardsDoneButtonPressed))
        
        toolBar.setItems([indent, doneButton], animated: false)
        
        textField.inputAccessoryView = toolBar
    }
}

extension UIColor {
    
    var redValue: CGFloat{ return CIColor(color: self).red }
    var greenValue: CGFloat{ return CIColor(color: self).green }
    var blueValue: CGFloat{ return CIColor(color: self).blue }
}

