import UIKit
//==//Объявление и вызов функций
func hello(name: String, age: Int, city: String)-> String{
   return "Hello  \(name) , your age is \(age), from \(city) how are you?"
    
}

let us = hello(name: "Yurii", age: 32, city: "Wroclaw")
print(us)

//==//Функции без параметров
func sayHelloWorld() -> String {
    return "hello, world"
}
print(sayHelloWorld())
// Выведет "hello, world"

//==//Функции с несколькими входными параметрами
func greet(person: String, alreadyGreeted: Bool) -> String {
//    if alreadyGreeted {
//        return greetAgain(person: person)
//    } else {
//        return greet(person: person, alreadyGreeted: <#Bool#>)
    return person
    }

print(greet(person: "Tim", alreadyGreeted: true))
// Выведет "Hello again, Tim!"

//==//Функции, не возвращающие значения
func greet(person: String) {
    print("Hello, \(person)!")
}
greet(person: "Dave")
// Выведет "Hello, Dave!"
//Выходное значение функции может быть игнорировано:
func printAndCount(string: String) -> Int {
    print(string)
    return string.count
}
func printWithoutCounting(string: String) {
    let _ = printAndCount(string: string)
}
printAndCount(string: "hello, world")
// Выведет "hello, world" и возвращает значение 12
printWithoutCounting(string: "hello, world")
// Выведет "hello, world", но не возвращает значения
                                                                                          
//==//Функции, возвращающие несколько значений
func MinMaxValue(array: [Int]) -> (min: Int, max: Int)? {
    if array.isEmpty {return nil}
  var  minValue = array[0]
  var  maxValue = array[0]
    for value in array[0..<array.count] {
        if value < minValue {
            minValue = value
        } else if value > maxValue {
            maxValue = value
        }
        }
    return( minValue, maxValue)
}

if let newMinMaxValue = MinMaxValue(array: [44,344,535,0,55]){
print("max value is \(newMinMaxValue.max), and min value is \(newMinMaxValue.min) ")
}


//==//Значения по умолчанию для параметров

func someFunc(parametrWithoutDefault: Int, parametrWithDefault: Int = 10 ) {
    
 someFunc(parametrWithoutDefault: 3, parametrWithDefault: 5) //parametrWithDefault = 5
 someFunc(parametrWithoutDefault: 5) //parametrWithDefault = 10
   
}

//==//Вариативные параметры
func variativnajaFunc(_ numbers: Double...)-> Double {
    var double: Double = 0
    for number in numbers {
        double += number
    }
    return double / Double(numbers.count)
}

let double = variativnajaFunc(9,98,789,78,8,7)
print(double)

//==//Сквозные параметры
func swapTwoInts(_ a: inout Int, _ b: inout Int){
    let temporaryA = a
    a = b
    b = temporaryA
    }

var someInt = 67
var anotherInt = 55

swap(&someInt, &anotherInt)
print("\(someInt)  \(anotherInt)")

//==//Использование функциональных типов
func addTwoInts(a: Int, _ b: Int) -> Int {
  return a + b
}
func multiplyTwoInts(a: Int, _ b: Int) -> Int {
  return a * b
}

var mathFunction: (Int, Int) -> Int = addTwoInts
print("Result: \(mathFunction(2, 3))")
// Выведет "Result: 5"

mathFunction = multiplyTwoInts
print("Result: \(mathFunction(2, 3))")
// Выведет "Result: 6"


//==//Функциональные типы как типы параметров
//Следующий код печатает на экране результаты работы приведенных выше математических функций:
func printMathResult(_ mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
    print("Result: \(mathFunction(a, b))")
}
printMathResult(addTwoInts, 3, 5)
// Выведет "Result: 8"

//==//Функциональные типы как возвращаемые типы
func stepForward(_ input: Int) -> Int {
    return input + 1
}
func stepBackward(_ input: Int) -> Int {
    return input - 1
}
func chooseStepFunction(backward: Bool) -> (Int) -> Int {
    return backward ? stepBackward : stepForward
}
var currentValue = 3
let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)
// moveNearerToZero now refers to the stepBackward() function
print("Counting to zero:")
// Counting to zero:
while currentValue != 0 {
    print("\(currentValue)... ")
    currentValue = moveNearerToZero(currentValue)
}
print("zero!")
// 3...
// 2...
// 1...
// zero!

//==// Вложенные функции
//Приведенный выше пример с функцией chooseStepFunction(backward:) можно переписать со вложенными функциями:
func chooseStepFunction2(backward: Bool) -> (Int) -> Int {
    func stepForward(input: Int) -> Int { return input + 1 }
    func stepBackward(input: Int) -> Int { return input - 1 }
    return backward ? stepBackward : stepForward
}
var currentValue2 = 9
let moveNearerToZero2 = chooseStepFunction2(backward: currentValue > 0)
// moveNearerToZero теперь ссылается на вложенную функцию stepForward()
while currentValue != 0 {
    print("\(currentValue)... ")
    currentValue = moveNearerToZero(currentValue)
}
print("zero!")
// -4...
// -3...
// -2...
// -1...
// zero!

