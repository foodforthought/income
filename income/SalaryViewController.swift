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

    @IBAction func calculateIncome(_ sender: AnyObject) {
        grossIncome.resignFirstResponder()

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
