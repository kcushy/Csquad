//
//  main.swift
//  UnitConverter
//
//  Created by Kims on 2018. 9. 13..
//  Copyright © 2018년 kcushy. All rights reserved.
//


import Foundation

// convert centimeter to meter
func convertCmToMeter(in cmStr: String) -> String {
    let setEnd = cmStr.index(cmStr.endIndex, offsetBy: -3)
    let rangeNum = ...setEnd
    let numStr = cmStr[rangeNum]
    if let numInt = Int(numStr) {
        let convertNum = numInt / 100
        let convertResult = String(convertNum) + "m"
        return convertResult
    } else {
        return String()
    }
}

// convert meter to centimeter
func convertMeterToCm(in meterStr: String) -> String {
    let setEnd = meterStr.index(meterStr.endIndex, offsetBy: -2)
    let rangeNum = ...setEnd
    let numStr = meterStr[rangeNum]
    if let numInt = Int(numStr) {
        let convertNum = numInt * 100
        let convertResult = String(convertNum) + "cm"
        return convertResult
    } else {
        return String()
    }
}

func printResult() {
    print(convertCmToMeter(in: "1200cm"))
    print(convertMeterToCm(in: "100m"))
}

printResult()
