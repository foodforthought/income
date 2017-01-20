//
//  IncomeCalculator.swift
//  income
//
//  Created by Mikkel C. Kim on 1/13/17.
//  Copyright © 2017 foodforthought. All rights reserved.
//

import Foundation

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
