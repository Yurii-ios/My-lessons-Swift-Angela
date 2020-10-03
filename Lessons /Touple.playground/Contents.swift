import Foundation
// perwuj sposob sozdanija
let touple1 = ("Yurii", 22)

print(touple1.0)

// wtoroj sposob sozdanija
let touple2 = (name: "Yurii", age: 22)

print(touple2.name)

// tretij sposob sozdanija
let touple3: (name: String, age: Int)
//touple3.name = "Yurii"
//touple3.age = 22
// ili zapisat koro4e
touple3 = (name: "Yurii", age: 22)
