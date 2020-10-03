import Foundation

class Animal {
    var name: String
    
    init(n: String){
        name = n
    }
}

class Human: Animal {
    func code() {
        print("Typing away...")
    }
}

class Fish: Animal {
    func breatherUnderWater() {
        print("Breathing under water.")
    }
}

let yurii = Human(n: "Yurii Sameliuk")
let irina = Human(n: "Irina Sameliuk")
let nemo = Fish(n: "Nemo")
let num = 12

// eti obektu mogno wpisat wmeste blagodaria tomy 4to oni ynasledowanue ot syperklasa Animal
// esli nam nygno smeshat masiw s raznumi tipami dannux nam nygno ispolzowat ---"Any"----
let neighbours:[Any] = [yurii,irina,nemo,num]

//---  is --- (type checking) prowerka tipow
// etoklu4ewoe slowo pozwoliaet nam imet obekt iz opredellennogo tipa dannux , a zatem prowerit imeet li obekt etot tip dannux
//let cell = UITableViewCell()
//if cell is UITableViewCell{
  //  }
// nachodim w masiwe objekt tipa fish
func findNemo(from animals: [Animal]) {
    for animal in animals {
        if animal is Fish {
            print(animal.name)
            //--- as! --- (Forsed Downcast) wunygdenoe ponigenie
            let fish = animal as! Fish
            // bez as! mu bu nesmogli wuzwat metod klasa Fish
            fish.breatherUnderWater()
           //  --- as --- (Upcast)ispolzuetsia dlia podniatija do swoego syperklasa
            let animalFish = fish as Animal
        }
        
    }
        
    
}
//--- as? --- opcionalnuj wuzow
// esli mu ne ywerenu w prawilnosti to nygno ispolzowat as? ,4tobu kod wupolnilsia, w protiwnom sly4ae prilogenie ypadet
findNemo(from: neighbours)

if let fish = neighbours[1] as? Fish {
    fish.breatherUnderWater()
}else {
    print("Casting has failed")
}
