//
//  IncomeViewController.swift
//  income
//
//  Created by Mikkel C. Kim on 1/13/17.
//  Copyright © 2017 foodforthought. All rights reserved.
//

import Foundation
import UIKit
import ChameleonFramework

class IncomeViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var filingStatus: [String] = [String]()
    var states: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        /*
        let gradientColors: [UIColor] = [FlatLime(), FlatGreen()]
        self.view.backgroundColor = GradientColor(UIGradientStyle.topToBottom, frame: self.view.frame, colors: gradientColors) */
        
        filingStatus = ["Single", "Married (joint)", "Married (separate)", "Head of household"]
        states = ["AK", "AL", "AR", "AZ", "CA", "CO", "CT", "DC", "DE", "FL", "GA", "HI", "IA", "ID", "IL", "IN", "KS", "KY", "LA", "MA", "MD", "ME", "MI", "MN", "MO", "MS", "MT", "NC", "ND", "NE", "NH", "NJ", "NM", "NV", "NY", "OH", "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VA", "VT", "WA", "WI", "WV", "WY"]
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        let existingTextHasDecimal = textField.text?.range(of: ".")
        let replacementTextHasDecimal = string.range(of: ".")
        let replacementTextAllCharacters = CharacterSet(charactersIn: string)
        let replacementTextOnlyDigits = CharacterSet.decimalDigits.isSuperset(of: replacementTextAllCharacters)
        
        if replacementTextHasDecimal != nil && existingTextHasDecimal != nil {
            return false
        } else {
            if replacementTextOnlyDigits == true {
                return true
            } else if replacementTextHasDecimal != nil {
                return true
            } else {
                return false
            }
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0 {
            return filingStatus.count
        } else {
            return states.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 0 {
            return filingStatus[row]
        } else {
            return states[row]
        }
    }
    
    func setView(view: UIView, hidden: Bool) {
        UIView.transition(with: view, duration: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {() -> Void in
            view.isHidden = hidden
        }, completion: { _ in })
    }
}
