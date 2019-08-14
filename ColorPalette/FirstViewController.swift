//
//  FirstViewController.swift
//  ColorPalette
//
//  Created by Viktor on 13/08/2019.
//  Copyright © 2019 Viktor. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, ColorDelegate {
    
    @IBOutlet var displayView: UIView!
    var color: UIColor = .black
    
    func sendColor(red: CGFloat, green: CGFloat, blue: CGFloat) {
        displayView.backgroundColor = UIColor(red: red,
                                              green: green,
                                              blue: blue,
                                              alpha: 1)
    }
    
    override func viewDidLoad() {
        displayView.backgroundColor = .black
        displayView.layer.cornerRadius = 15
        view.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! SettingsViewController
        vc.delegate = self
        vc.color = displayView.backgroundColor
    }
    
    
    @IBAction func settingsButtonPressed(_ sender: Any) {
        
    }
    
}
