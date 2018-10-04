
//
//  main.swift
//  UnitConverter
//
//  Created by Kims on 2018. 9. 13..
//  Copyright © 2018년 kcushy. All rights reserved.
//

import Foundation


enum InputError: Error {
    case notSupport
    case incorrectInput
}

// type collection
// completed: Use struct and type property, DTO..? 포함관  계 has-a
struct Standard {
    static let unit = ["cm": 1, "m": 100, "inch": 2.54, "yard": 91.44, "g": 1, "kg": 1000, "oz": 28.35, "lb": 453.59]
    static let numberID = "1234567890."
    static var length: Set<String> = ["cm", "m", "inch", "yard"]
    static var weight: Set<String> = ["g", "kg", "oz", "lb"]
}

// input a initial value
// TODO: do-try-catch
func request() -> String {
    print("********************** 단위변환기 Beta *******************\n")
    print("지원하는 단위는 다음과 같습니다. 단 같은 단위끼리의 변환만 가능합니다.\n")
    print("길이: \(Standard.length.joined(separator: ", ")),\n무게: \(Standard.weight.joined(separator: ", "))\n")
    print("*******************************************************\n")
    print("변환할 값과 단위를 입력하세요 e.g. 180cm m\n: ", terminator: "")
    var output = String()
    if let message = readLine() {
        output = message.trimmingCharacters(in: .whitespaces)
    }
    return output
}

// divide two input value
// if input has a blank, like inch,(blank)yard, how to solve?
func divideInto(_ userInput: String) throws ->  (userValue: String, unit: Array<String>) {
    let twoOrOne = userInput.components(separatedBy: " ").map{ String($0) }
    let value = twoOrOne[0]
    guard checkIt(has: twoOrOne) else {
        let target = subtract(value: value)
        return (value, target)
    }
    let target = twoOrOne[1].components(separatedBy: ",")
    print(target)
    guard !target.contains("") else {
        throw InputError.incorrectInput
    }
    return (value, target)
}

// subtract set
func subtract(value: String) -> Array<String> {
    let origin = splitInto(input: value).unit
    let target: Set<String> = [origin]
    guard Standard.length.contains(origin) else {
        return Array(Standard.weight.subtracting(target))
    }
    return Array(Standard.length.subtracting(target))
}

// divide input value into value and unit
func splitInto(input: String) -> (value: String, unit: String) {
    var originValue = String()
    var originUnit = String()
    for value in input {
        switch Standard.numberID.contains(value) {
        case true:
            originValue.append(value)
        default:
            originUnit.append(value)
        }
    }
    return (originValue, originUnit)
}

// check whether input value has two unit
func checkIt(has: Array<String>) -> Bool {
    return has.indices.contains(1)
}


// search and convert unit's value
func searchAndConvert(_ originUnit: String, _ unitToConvert: String) -> (originValue: Double, valueToConvert: Double) {
    var originValue = Double()
    var valueToConvert = Double()
    for (unit, value) in Standard.unit {
        if unit == originUnit {
            originValue = value
        } else if unit == unitToConvert {
            valueToConvert = value
        }
    }
    return (originValue, valueToConvert)
}

// check the unit is supported.
func checkSupportUnit(_ target: Array<String>) -> Bool {
    let supportedUnit = Standard.unit.keys
    for unit in target {
        guard supportedUnit.contains(unit) else {
            return false
        }
    }
    return true
}

// check same types
// FIX ME: try not to use "if~else"
func isSameUnit(_ origin: String, _ target: Array<String>) -> Bool {
    var result = false
    for unit in target {
        if Standard.length.contains(origin) && Standard.length.contains(unit) {
            result = true
        }
        else if Standard.weight.contains(origin) && Standard.weight.contains(unit) {
            result = true
        }
    }
    return result
}

// calculate value to convert
func calculateUnit(_ originValue: Double, _ originUnit: String, _ unitsToCovert: Array<String>) {
    for targetUnit in unitsToCovert {
        let outcome = searchAndConvert(originUnit, targetUnit)
        let startValue = outcome.originValue
        let endValue = outcome.valueToConvert
        let result = originValue * startValue / endValue
        print(">>>> \(result) \(targetUnit)")
    }
    print("")
}

// print result
// FIX ME: seperate function and check overlap variables and
func convert() {
    while true {
        do {
            let userInput = request()
            let input = try! divideInto(userInput).userValue
            guard (input != "q") && (input != "quit") else {
                print("\n프로그램이 종료됩니다")
                return
            }
            let value = (input as NSString).doubleValue    // which is better? unwrap optional or this
            let origin = splitInto(input: input).unit
            let target = try divideInto(userInput).unit
            let isEqual = isSameUnit(origin, target)
            let isSupport = checkSupportUnit(target)
            guard isSupport && isEqual else {
                print("지원하지 않는 단위입니다. 다시 입력해주세요\n")
                continue
            }
            calculateUnit(value, origin, target)
        } catch InputError.incorrectInput {
            print("공백 없이 입력해주세요\n")
        } catch {
            print("알 수 없는 에러가 발생했습니다\n")
        }
    }
}

convert()
