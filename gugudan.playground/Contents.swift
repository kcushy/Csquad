//: Playground - noun: a place where people can play

import Cocoa

import Cocoa

//2, 3단 단순출력
print("2 * 1 = \(2 * 1)")
print("2 * 2 = \(2 * 2)")
print("2 * 3 = \(2 * 3)")
print("2 * 4 = \(2 * 4)")
print("2 * 5 = \(2 * 5)")
print("2 * 6 = \(2 * 6)")
print("2 * 7 = \(2 * 7)")
print("2 * 8 = \(2 * 8)")
print("2 * 9 = \(2 * 9)")
print("")
print("3 * 1 = \(3 * 1)")
print("3 * 2 = \(3 * 2)")
print("3 * 3 = \(3 * 3)")
print("3 * 4 = \(3 * 4)")
print("3 * 5 = \(3 * 5)")
print("3 * 6 = \(3 * 6)")
print("3 * 7 = \(3 * 7)")
print("3 * 8 = \(3 * 8)")
print("3 * 9 = \(3 * 9)")
print("==========================================")

//4,5단 변수 활용
let numFour = 4
var result = numFour * 1
print("\(numFour) * 1 = \(result)")
result = numFour * 2
print("\(numFour) * 2 = \(result)")
result = numFour * 3
print("\(numFour) * 3 = \(result)")
result = numFour * 4
print("\(numFour) * 4 = \(result)")
result = numFour * 5
print("\(numFour) * 5 = \(result)")
result = numFour * 6
print("\(numFour) * 6 = \(result)")
result = numFour * 7
print("\(numFour) * 7 = \(result)")
result = numFour * 8
print("\(numFour) * 8 = \(result)")
result = numFour * 9
print("\(numFour) * 9 = \(result)")
print("")

let numFive = 5
result = numFive * 1
print("\(numFive) * 1 = \(result)")
result = numFive * 2
print("\(numFive) * 2 = \(result)")
result = numFive * 3
print("\(numFive) * 3 = \(result)")
result = numFive * 4
print("\(numFive) * 4 = \(result)")
result = numFive * 5
print("\(numFive) * 5 = \(result)")
result = numFive * 6
print("\(numFive) * 6 = \(result)")
result = numFive * 7
print("\(numFive) * 7 = \(result)")
result = numFive * 8
print("\(numFive) * 8 = \(result)")
result = numFive * 9
print("\(numFive) * 9 = \(result)")
print("==========================================")

//6,7단 반복문 활용
let numSix = 6
for number in 1..<10 {
    result = numSix * number
    print("\(numSix) * \(number) = \(result)")
}
print("")
let numSeven = 7
for number in 1..<10 {
    result = numSeven * number
    print("\(numSeven) * \(number) = \(result)")
}
print("==========================================")

//구구단 홀수 이중반복문 활용
for frontNum in 2..<10 {
    if frontNum % 2 == 1 {
        for backNum in 1..<10 {
            print("\(frontNum) * \(backNum) = \(frontNum * backNum)")
        }
    }
    print("")
}
print("==========================================")

//구구단 2단 배열 활용
var gugudanTwo = [Int].init(repeating: 0, count: 9)
let numTwo = 2

for index in 0..<gugudanTwo.count {
    gugudanTwo[index] = numTwo * (index + 1)
}

for (index, value) in gugudanTwo.enumerated() {
    print("\(numTwo) * \(index + 1) = \(value)")
}
print("==========================================")

//서브루틴 활용해서 1~9단 출력
func gugudanArray(firstNum: Int) -> Array<Int> {
    var someArray = [Int].init(repeating: 0, count: 9)
    let arrayCount = someArray.count
    for index in 0..<arrayCount {
        let secondNum = index + 1
        someArray[index] = firstNum * secondNum
    }
    return someArray
}

func printArray(firstNum: Int, gugudanArray: Array<Int>) {
    for (index, result) in gugudanArray.enumerated() {
        let secondNum = index + 1
        print("\(firstNum) * \(secondNum) = \(result)")
    }
}

func finalResult(firstNum: Int) {
    let maxNum = firstNum + 1
    for element in 1..<maxNum {
        let resultArray: Array<Int> = gugudanArray(firstNum: element)
        printArray(firstNum: element, gugudanArray: resultArray)
        print("")
    }
}

finalResult(firstNum: 9)
