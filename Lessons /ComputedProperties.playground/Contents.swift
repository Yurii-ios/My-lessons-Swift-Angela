import Foundation
// eto soxranenue cwojstwa
let pizzaInInchesc1: Int = 10
// eto soxranenue cwojstwa
var numberOfSlices1: Int = 6


let pizzaInInchesc: Int = 16
var numberOfPeople: Int = 12
let slicesPerPerson: Int = 5
// wu4esliaemaja peremennaja - Getter
//1 prawilo - dolgna but var
//2 - dolgen but ykazat tip wu4esliaemogo swoistwa naprimer Int, Double, Float i td...
var numberOfSlices: Int {
    get {
 return pizzaInInchesc - 4
    }
    // wupolniaetsia kogda peremennaja "numberOfSlices" poly4aet nowoe zna4enije
    set {
        // newValue - specialnaja peremennaja
        print("number slices \(newValue)")
    }
}
//numberOfSlices = 12
//print(numberOfSlices)

var numberOfPizza: Int {
    get{
        let numberOfPeopleFedPerPizza = numberOfSlices / slicesPerPerson
        return numberOfPeople / numberOfPeopleFedPerPizza
    }
    set {
        let totalSlices = numberOfSlices * newValue
        numberOfPeople = totalSlices / slicesPerPerson
    }
}
numberOfPizza = 4
print(numberOfPeople)

// nabludaemaja peremennaja
var pizzaInInchesc2: Int = 10 {
    // monitorit pered izmeneniem swoistwa
    willSet {
        print(pizzaInInchesc2)
        print(newValue)
    }
    //monitorit posle izmenenija swoistwa
    didSet {
        print(oldValue)
        print(pizzaInInchesc2)
        if pizzaInInchesc2 >= 18 {
            print("invalid size")
        }
    }
}

pizzaInInchesc2 = 5
