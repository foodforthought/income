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
    
    @IBOutlet weak var hourlyWage: UITextField!
    @IBOutlet weak var numberOfHoursPerWeek: UITextField!
    @IBOutlet weak var deduction: UITextField!
    @IBOutlet weak var ira: UITextField!
    @IBOutlet weak var healthcare: UITextField!
    @IBOutlet weak var filingStatusAndStatePicker: UIPickerView!
    @IBOutlet weak var netIncome: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.hourlyWage.delegate = self
        self.deduction.delegate = self
        self.ira.delegate = self
        self.healthcare.delegate = self
        
        self.filingStatusAndStatePicker.delegate = self
        self.filingStatusAndStatePicker.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func calculateIncome(_ sender: AnyObject) {
        hourlyWage.resignFirstResponder()
        
        let hourlyWageFloat: Float = Float(hourlyWage.text!)!
        let numberOfHoursPerWeekFloat: Float = Float(numberOfHoursPerWeek.text!)!
        let deductionFloat: Float = Float(deduction.text!)!
        let iraFloat: Float = Float(ira.text!)!
        let healthcareFloat: Float = Float(healthcare.text!)!
        
        let grossIncome: Float = hourlyWageFloat * numberOfHoursPerWeekFloat * 52
        
        let taxableIncome: Float = grossIncome - deductionFloat - iraFloat - healthcareFloat
        let federalIncomeTax: Float = computeFederalIncomeTax(taxableIncome: taxableIncome, filingStatusIdx: filingStatusAndStatePicker.selectedRow(inComponent: 0))
        let stateIncomeTax: Float = computeStateIncomeTax(taxableIncome: taxableIncome, stateIdx: filingStatusAndStatePicker.selectedRow(inComponent: 1))
        
        netIncome.text = String(taxableIncome - federalIncomeTax - stateIncomeTax)
    }
    
}
