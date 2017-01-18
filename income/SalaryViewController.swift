//
//  ViewController.swift
//  CalculateIncome
//
//  Created by Mikkel C. Kim on 1/9/17.
//  Copyright © 2017 Mikkel C. Kim. All rights reserved.
//

import ChameleonFramework
import UIKit

class SalaryViewController: IncomeViewController {
    @IBOutlet weak var grossIncomeLabel: UILabel!
    @IBOutlet weak var deductionLabel: UILabel!
    @IBOutlet weak var iraLabel: UILabel!
    @IBOutlet weak var healthcareLabel: UILabel!

    @IBOutlet weak var grossIncome: UITextField!
    @IBOutlet weak var deduction: UITextField!
    @IBOutlet weak var ira: UITextField!
    @IBOutlet weak var healthcare: UITextField!
    @IBOutlet weak var filingStatusPicker: UIPickerView!
    @IBOutlet weak var statePicker: UIPickerView!
    @IBOutlet weak var netIncome: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        self.grossIncome.delegate = self
        self.deduction.delegate = self
        self.ira.delegate = self
        self.healthcare.delegate = self
        
        self.filingStatusPicker.delegate = self
        self.filingStatusPicker.dataSource = self
        
        self.statePicker.delegate = self
        self.statePicker.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.tag == 0 {
            grossIncomeLabel?.textColor = FlatOrange()
        } else if textField.tag == 1 {
            deductionLabel?.textColor = FlatOrange()
        } else if textField.tag == 2 {
            iraLabel?.textColor = FlatOrange()
        } else {
            healthcareLabel?.textColor = FlatOrange()
        }
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.tag == 0 {
            grossIncomeLabel?.textColor = FlatBlack()
        } else if textField.tag == 1 {
            deductionLabel?.textColor = FlatBlack()
        } else if textField.tag == 2 {
            iraLabel?.textColor = FlatBlack()
        } else {
            healthcareLabel?.textColor = FlatBlack()
        }
        return true
    }

    @IBAction func calculateIncome(_ sender: AnyObject) {
        grossIncome.resignFirstResponder()
        deduction.resignFirstResponder()
        ira.resignFirstResponder()
        healthcare.resignFirstResponder()
        
        if grossIncome.text!.isEmpty {
            grossIncome.text! = "0"
        }
        if deduction.text!.isEmpty {
            deduction.text! = "0"
        }
        if ira.text!.isEmpty {
            ira.text! = "0"
        }
        if healthcare.text!.isEmpty {
            healthcare.text! = "0"
        }

        let grossIncomeFloat: Float = Float(grossIncome.text!)!
        let deductionFloat: Float = Float(deduction.text!)!
        let iraFloat: Float = Float(ira.text!)!
        let healthcareFloat: Float = Float(healthcare.text!)!
        
        let taxableIncome: Float = grossIncomeFloat - deductionFloat - iraFloat - healthcareFloat
        let federalIncomeTax: Float = computeFederalIncomeTax(taxableIncome: taxableIncome, filingStatusIdx: filingStatusPicker.selectedRow(inComponent: 0))
        let stateIncomeTax: Float = computeStateIncomeTax(taxableIncome: taxableIncome, stateIdx: statePicker.selectedRow(inComponent: 0))
        
        netIncome.text = String(taxableIncome - federalIncomeTax - stateIncomeTax)
    }

}
