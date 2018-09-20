//
//  main.swift
//  UnitConverter
//
//  Created by Kims on 2018. 9. 13..
//  Copyright © 2018년 kcushy. All rights reserved.
//


import Foundation

// type collection
// FIX ME: Use struct static
func collectTypes() -> (dict: Dictionary<String, Double>, exceptDict: Dictionary<String, String>,valueStandard: String, setLength: Array<String>, setWeight: Array<String>) {
    let convertUnitStandards: [String: Double] = ["cm": 1, "m": 100, "inch": 2.54, "yard": 91.44, "g": 1, "kg": 1000, "oz": 28.35, "lb": 453.59]
    let applyExceptDict = ["m": "cm", "cm": "m", "yard": "m"]
    let setValueStandard = "1234567890."
    let setLength = ["cm", "m", "inch", "yard"]
    let setWeight = ["g", "kg", "oz", "lb"]
    return (convertUnitStandards, applyExceptDict, setValueStandard, setLength, setWeight)
}

// input a initial value
func inputMessage() -> String {
    var outputMessage = String()
    if let message = readLine() {
        outputMessage = message.trimmingCharacters(in: .whitespaces)
    }
    return outputMessage
}

// divide two input value
func divideTwoInputValues(inputtedUserValue: String) ->  (valueUnit: String, unit: String) {
    var dividedValueUnit = String()
    var dividedUnit = String()
    let dividedStr = inputtedUserValue.split(separator: " ")
    dividedValueUnit = String(dividedStr[0])
    guard checkTwoUnitHave(in: dividedStr) else {
        let returnExceptResult = checkExceptCase(in: dividedValueUnit)
        dividedValueUnit = returnExceptResult.valueUnit
        dividedUnit = returnExceptResult.unit
        return (dividedValueUnit, dividedUnit)
    }
    dividedUnit = String(dividedStr[1])
    return (dividedValueUnit, dividedUnit)
}

// divide input value into value and unit
func splitValueAndUnit(in inputValue: String) -> (value: String, unit: String) {
    var dividedNumValue = String()
    var dividedUnitValue = String()
    let setStandard = collectTypes().valueStandard
    for value in inputValue {
        switch setStandard.contains(value) {
        case true:
            dividedNumValue.append(value)
        default:
            dividedUnitValue.append(value)
        }
    }
    return (dividedNumValue, dividedUnitValue)
}


// check whether input value has two unit
func checkTwoUnitHave(in inputValue: Array<Substring>) -> Bool {
    return inputValue.indices.contains(1)
}

// check except case(have cm, inch, m, yd?)
func checkExceptCase(in inputValueUnit: String) -> (valueUnit: String, unit: String) {
    let splitUnit = splitValueAndUnit(in: inputValueUnit).unit
    var unitToConvert = String()
    let applyExceptDict = collectTypes().exceptDict
    guard applyExceptDict.keys.contains(splitUnit) else {
        return (inputValueUnit, unitToConvert)
    }
    if let unit = applyExceptDict[splitUnit] {
        unitToConvert = String(unit)
    }
    return (inputValueUnit, unitToConvert)
}

// search and convert unit's value
func searchUnitAndConvertTwoUnit(separatedUnit: String, unitToConvert: String) -> (convertedInputUnitValue: Double, unitToConvertValue: Double) {
    let convertUnitStandards = collectTypes().dict
    var convertedInputUnitValue = Double()
    var unitToConvertValue = Double()
    for (givenStandardUnit, givenStandardValue) in convertUnitStandards {
        if givenStandardUnit == separatedUnit {
            convertedInputUnitValue = givenStandardValue
        } else if givenStandardUnit == unitToConvert {
            unitToConvertValue = givenStandardValue
        }
    }
    return (convertedInputUnitValue, unitToConvertValue)
}

// check the unit is supported.
func checkSupportUnit(unitToConvert: String) -> Bool {
    let supportedUnit = collectTypes().dict.keys
    let checkedResult = supportedUnit.contains(unitToConvert)
    return checkedResult
}

// check same types
// FIX ME: try not to use "if~else"
func checkSameTypes(dividedUnit: String, unitToConvert: String) -> Bool {
    let setLength = collectTypes().setLength
    let setWeight = collectTypes().setWeight
    let dividedUnit = splitValueAndUnit(in: dividedUnit).unit
    if setLength.contains(dividedUnit) && setLength.contains(unitToConvert) {
        return true
    } else if setWeight.contains(dividedUnit) && setWeight.contains(unitToConvert) {
        return true
    }
    return false
}

// calculate converting value
func calculateValue(dividedValue: Double, dividedUnit: String, unitToConvert: String) -> Double {
    let convertedResult = searchUnitAndConvertTwoUnit(separatedUnit: dividedUnit, unitToConvert: unitToConvert)
    let convertedInputValue = convertedResult.convertedInputUnitValue
    let unitToConvertValue = convertedResult.unitToConvertValue
    return dividedValue * convertedInputValue / unitToConvertValue
}

// print result
// FIX ME: seperate function and check overlap variables and
func convertResult() {
    while true {
        print("변환할 값과 단위를 입력하세요 e.g. 180cm m\n: ", terminator: "")
        let inputtedUserValue = inputMessage()
        guard (inputtedUserValue != "q") && (inputtedUserValue != "quit") else {
            print("\n프로그램이 종료됩니다")
            return
        }
        let dividedTwoObjects = divideTwoInputValues(inputtedUserValue: inputtedUserValue)
        let inputValueUnit = dividedTwoObjects.valueUnit
        let unitToConvert = dividedTwoObjects.unit
        let dividedObject = splitValueAndUnit(in: inputValueUnit)
        let dividedUnit = dividedObject.unit
        let dividedValue = (dividedObject.value as NSString).doubleValue    // which is better? unwrap optional or this
        let checkedTypes = checkSameTypes(dividedUnit: dividedUnit, unitToConvert: unitToConvert)
        let checkedSupportUnit = checkSupportUnit(unitToConvert: unitToConvert)
        guard checkedSupportUnit && checkedTypes else {
            print("지원하지 않는 단위입니다. 다시 입력해주세요\n")
            continue
        }
        let calculatedValue = calculateValue(dividedValue: dividedValue, dividedUnit: dividedUnit, unitToConvert: unitToConvert)
        print("")
        print(String(calculatedValue) + unitToConvert)
    }
}

convertResult()

