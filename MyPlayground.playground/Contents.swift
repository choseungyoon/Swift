import UIKit
import Darwin

/*
 Chapter 4. 데이터 타입 고급
 */

// 연관 값
enum PastaTaste {
    case cream , tomato
}

enum PizzaDough {
    case cheeseCrust , thin , original
}

enum PizzaTopping {
    case pepperoni , cheese , bacon
}

enum MainDish {
    case pasta(taste : PastaTaste)
    case pizza(dough : PizzaDough , topping: PizzaTopping)
    case chicken(withSause: Bool)
    case rice
}

var dinner: MainDish = MainDish.pasta(taste: .tomato)
dinner = MainDish.pizza(dough: .cheeseCrust, topping: .cheese)

print(dinner)

// 항목 순회
enum School: CaseIterable {
    case primary
    case elementary
    case middle
    case high
    case college
    case university
    case graduate
}
let allCases: [School] = School.allCases
print(allCases)

// available 속성을 갖는 열거형의 항목 순회
enum School2: String, CaseIterable {
    case primary = "유치원"
    case elementary = "초등학교"
    case middle = "중학교"
    case high = "고등학교"
    case college = "대학"
    case university = "대학교"
    @available(iOS, obsoleted:12.0)
    case graduate = "대학원"
    
    static var allCases: [School2]{
        let all: [School2] = [.primary,.elementary,.middle,.high,.college,.university]
        
        #if os(iOS)
        return all
        #else
        return all + [.graduate]
        #endif
    }
}

let allCases2: [School2] = School2.allCases
print(allCases2)

// 순환 열거형
enum ArithmeticExpression {
    case number(Int)
    indirect case addition(ArithmeticExpression,ArithmeticExpression)
    indirect case multiplication(ArithmeticExpression,ArithmeticExpression)
}

let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)

let sum = ArithmeticExpression.addition(five, four)
let final = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))

func evaluate(_ expression: ArithmeticExpression) -> Int {
    switch expression {
    case .number(let value):
        return value
    case .addition(let left, let right):
        return evaluate(left)+evaluate(right)
    case .multiplication(let left, let right):
        return evaluate(left)*evaluate(right)
    }
}

let result: Int = evaluate(final)
print(result)
