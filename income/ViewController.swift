//
//  ViewController.swift
//  CalculateIncome
//
//  Created by Mikkel C. Kim on 1/9/17.
//  Copyright © 2017 Mikkel C. Kim. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var grossIncome: UITextField!
    @IBOutlet weak var deduction: UITextField!
    @IBOutlet weak var ira: UITextField!
    @IBOutlet weak var healthcare: UITextField!
    @IBOutlet weak var statePicker: UIPickerView!
    @IBOutlet weak var netIncome: UILabel!
    
    var gender: [String] = [String]()
    var filingStatus: [String] = [String]()
    var states: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.statePicker.delegate = self
        self.statePicker.dataSource = self
        
        gender = ["Male", "Female", "Unknown"]
        filingStatus = ["Single", "Married (joint)", "Married (separate)", "Head of household", "Widow"]
        states = ["Texas", "California", "New York", "Washington"]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        if(component == 0) {
            return gender.count
        } else if(component == 1) {
            return filingStatus.count
        } else {
            return states.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(component == 0) {
            return gender[row]
        } else if(component == 1) {
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
        
        netIncome.text = String(grossIncomeFloat - deductionFloat - iraFloat - healthcareFloat)

    }

}

