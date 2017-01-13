//
//  ViewController.swift
//  CalculateIncome
//
//  Created by Mikkel C. Kim on 1/9/17.
//  Copyright © 2017 Mikkel C. Kim. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var grossIncome: UITextField!
    @IBOutlet weak var deduction: UITextField!
    @IBOutlet weak var ira: UITextField!
    @IBOutlet weak var healthcare: UITextField!
    @IBOutlet weak var filingStatusAndStatePicker: UIPickerView!
    @IBOutlet weak var netIncome: UILabel!
    
    var filingStatus: [String] = [String]()
    var states: [String] = [String]()
    var singleTaxBracket: [Float:Float] = [Float:Float]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.grossIncome.delegate = self
        self.deduction.delegate = self
        self.ira.delegate = self
        self.healthcare.delegate = self
        
        self.filingStatusAndStatePicker.delegate = self
        self.filingStatusAndStatePicker.dataSource = self
        
        filingStatus = ["Single", "Married (joint)", "Married (separate)", "Head of household"]
        states = ["AK", "AL", "AR", "AZ", "CA", "CO", "CT", "DC", "DE", "FL", "GA", "HI", "IA", "ID", "IL", "IN", "KS", "KY", "LA", "MA", "MD", "ME", "MI", "MN", "MO", "MS", "MT", "NC", "ND", "NE", "NH", "NJ", "NM", "NV", "NY", "OH", "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VA", "VT", "WA", "WI", "WV", "WY"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    func computeFederalIncomeTax(taxableIncome: Float, filingStatusIdx: Int) -> Float {
        if filingStatusIdx == 0 {
            return computeFederalIncomeTaxForSingle(taxableIncome: taxableIncome)
        } else if filingStatusIdx == 1 {
            return computeFederalIncomeTaxForMarriedJoint(taxableIncome: taxableIncome)
        } else if filingStatusIdx == 2 {
            return computeFederalIncomeTaxForMarriedSeparate(taxableIncome: taxableIncome)
        } else {
            return computeFederalIncomeTaxForHeadOfHousehold(taxableIncome: taxableIncome)
        }
        
    }
    
    func computeFederalIncomeTaxForSingle(taxableIncome: Float) -> Float {
        if taxableIncome <= 9_325 {
            return taxableIncome * 0.1
        } else if taxableIncome <= 37_950 {
            return (taxableIncome - 9_325) * 0.15 + 932.50
        } else if taxableIncome <= 91_900 {
            return (taxableIncome - 37_950) * 0.25 + 5_226.25
        } else if taxableIncome <= 191_650 {
            return (taxableIncome - 91_900) * 0.28 + 18_713.75
        } else if taxableIncome <= 416_700 {
            return (taxableIncome - 191_650) * 0.33 + 46_643.75
        } else if taxableIncome <= 418_400 {
            return (taxableIncome - 416_700) * 0.35 + 120_910.25
        } else {
            return (taxableIncome - 418_400) * 0.396 + 121_505.25
        }
    }
    
    func computeFederalIncomeTaxForMarriedJoint(taxableIncome: Float) -> Float {
        if taxableIncome <= 18_650 {
            return taxableIncome * 0.1
        } else if taxableIncome <= 75_900 {
            return (taxableIncome - 18_650) * 0.15 + 1865
        } else if taxableIncome <= 153_100 {
            return (taxableIncome - 75_900) * 0.25 + 10_452.50
        } else if taxableIncome <= 233_350 {
            return (taxableIncome - 153_100) * 0.28 + 23_752.50
        } else if taxableIncome <= 416_700 {
            return (taxableIncome - 233_350) * 0.33 + 52_222.50
        } else if taxableIncome <= 470_700 {
            return (taxableIncome - 416_700) * 0.35 + 112_728
        } else {
            return (taxableIncome - 470_700) * 0.396 + 131_628
        }
    }
    
    func computeFederalIncomeTaxForMarriedSeparate(taxableIncome: Float) -> Float {
        if taxableIncome <= 9_325 {
            return taxableIncome * 0.1
        } else if taxableIncome <= 37_950 {
            return (taxableIncome - 9_325) * 0.15 + 932.50
        } else if taxableIncome <= 76_550 {
            return (taxableIncome - 37_950) * 0.25 + 5_226.25
        } else if taxableIncome <= 116_675 {
            return (taxableIncome - 76_550) * 0.28 + 14_876.25
        } else if taxableIncome <= 208_350 {
            return (taxableIncome - 116_675) * 0.33 + 26_111.25
        } else if taxableIncome <= 235_350 {
            return (taxableIncome - 208_350) * 0.35 + 56_164
        } else {
            return (taxableIncome - 235_350) * 0.396 + 65_814
        }
    }
    
    func computeFederalIncomeTaxForHeadOfHousehold(taxableIncome: Float) -> Float {
        if taxableIncome <= 13_350 {
            return taxableIncome * 0.1
        } else if taxableIncome <= 50_800 {
            return (taxableIncome - 13_350) * 0.15 + 1_335
        } else if taxableIncome <= 131_200 {
            return (taxableIncome - 50_805) * 0.25 + 6_952.50
        } else if taxableIncome <= 212_500 {
            return (taxableIncome - 131_200) * 0.28 + 27_052.50
        } else if taxableIncome <= 416_700 {
            return (taxableIncome - 212_500) * 0.33 + 49_816.50
        } else if taxableIncome <= 444_550 {
            return (taxableIncome - 416_700) * 0.35 + 117_202.50
        } else {
            return (taxableIncome - 444_550) * 0.396 + 126_950
        }
    }
    
    func computeStateIncomeTax(taxableIncome: Float, stateIdx: Int) -> Float {
        return 0
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        if component == 0 {
            return filingStatus.count
        } else {
            return states.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return filingStatus[row]
        } else {
            return states[row]
        }
    }

    @IBAction func calculateIncome(_ sender: AnyObject) {
        grossIncome.resignFirstResponder()

        let grossIncomeFloat: Float = Float(grossIncome.text!)!
        let deductionFloat: Float = Float(deduction.text!)!
        let iraFloat: Float = Float(ira.text!)!
        let healthcareFloat: Float = Float(healthcare.text!)!
        
        let taxableIncome: Float = grossIncomeFloat - deductionFloat - iraFloat - healthcareFloat
        let federalIncomeTax: Float = computeFederalIncomeTax(taxableIncome: taxableIncome, filingStatusIdx: filingStatusAndStatePicker.selectedRow(inComponent: 0))
        let stateIncomeTax: Float = computeStateIncomeTax(taxableIncome: taxableIncome, stateIdx: filingStatusAndStatePicker.selectedRow(inComponent: 1))
        
        netIncome.text = String(taxableIncome - federalIncomeTax - stateIncomeTax)
    }

}

