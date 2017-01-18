//
//  HourlyWangeViewController.swift
//  income
//
//  Created by Hyunchel Kim on 1/12/17.
//  Copyright © 2017 foodforthought. All rights reserved.
//

import Foundation
import ChameleonFramework
import UIKit

class HourlyWageViewController: IncomeViewController {
    @IBOutlet weak var hourlyWageLabel: UILabel!
    @IBOutlet weak var numberOfHoursPerWeekLabel: UILabel!
    @IBOutlet weak var deductionLabel: UILabel!
    @IBOutlet weak var iraLabel: UILabel!
    @IBOutlet weak var healthcareLabel: UILabel!
    
    @IBOutlet weak var hourlyWage: UITextField!
    @IBOutlet weak var numberOfHoursPerWeek: UITextField!
    @IBOutlet weak var deduction: UITextField!
    @IBOutlet weak var ira: UITextField!
    @IBOutlet weak var healthcare: UITextField!
    @IBOutlet weak var filingStatusPicker: UIPickerView!
    @IBOutlet weak var statePicker: UIPickerView!
    @IBOutlet weak var netIncome: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.hourlyWage.delegate = self
        self.numberOfHoursPerWeek.delegate = self
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
            hourlyWageLabel?.textColor = FlatOrange()
        } else if textField.tag == 1 {
            numberOfHoursPerWeekLabel?.textColor = FlatOrange()
        } else if textField.tag == 2 {
            deductionLabel?.textColor = FlatOrange()
        } else if textField.tag == 3 {
            iraLabel?.textColor = FlatOrange()
        } else {
            healthcareLabel?.textColor = FlatOrange()
        }
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.tag == 0 {
            hourlyWageLabel?.textColor = FlatBlack()
        } else if textField.tag == 1 {
            numberOfHoursPerWeekLabel?.textColor = FlatBlack()
        } else if textField.tag == 2 {
            deductionLabel?.textColor = FlatBlack()
        } else if textField.tag == 3 {
            iraLabel?.textColor = FlatBlack()
        } else {
            healthcareLabel?.textColor = FlatBlack()
        }
        return true
    }
    
    @IBAction func calculateIncome(_ sender: AnyObject) {
        hourlyWage.resignFirstResponder()
        numberOfHoursPerWeek.resignFirstResponder()
        deduction.resignFirstResponder()
        ira.resignFirstResponder()
        healthcare.resignFirstResponder()
        
        if hourlyWage.text!.isEmpty {
            hourlyWage.text! = "0"
        }
        if numberOfHoursPerWeek.text!.isEmpty {
            numberOfHoursPerWeek.text! = "0"
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
        
        let hourlyWageFloat: Float = Float(hourlyWage.text!)!
        let numberOfHoursPerWeekFloat: Float = Float(numberOfHoursPerWeek.text!)!
        let deductionFloat: Float = Float(deduction.text!)!
        let iraFloat: Float = Float(ira.text!)!
        let healthcareFloat: Float = Float(healthcare.text!)!
        
        let grossIncome: Float = hourlyWageFloat * numberOfHoursPerWeekFloat * 52
        
        let taxableIncome: Float = grossIncome - deductionFloat - iraFloat - healthcareFloat
        let federalIncomeTax: Float = computeFederalIncomeTax(taxableIncome: taxableIncome, filingStatusIdx: filingStatusPicker.selectedRow(inComponent: 0))
        let stateIncomeTax: Float = computeStateIncomeTax(taxableIncome: taxableIncome, stateIdx: statePicker.selectedRow(inComponent: 0))
        
        netIncome.text = String(taxableIncome - federalIncomeTax - stateIncomeTax)
    }
    
}
