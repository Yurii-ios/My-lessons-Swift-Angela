
protocol CanFly {
    func fly()
    // protokolu mogut prinimatsia ksk klasami tak i struktyrami

    
}



// problema w tom 4to nasledyja klasu mu poly4aem nenygnue swoystwa. tak naprimer camolet moget nesti jajca kak widno s promera nige, kogda on ynaslidowal eto swiistwo ot bird wmerse s poletom . w takix sly4ajax na pomos4 prixodiat Protokolu
class Bird {
    
    var isFemale = true
    
    func layEgg(){
        if isFemale{
            print("The bird is Female")
        }
    }
    
    }

 // nasledyem klass Bird
class Eagle: Bird, CanFly {
    // fynkcuja protokola kotoraja dolgna but realizivana tam gde mu wuzuwaem nach protokol
    func fly() {
        <#code#>
    }
    
        
        func soap(){
            print("The bird fluing")
        }
        
    }

class Penguin: Bird{
    
    func swim(){
        
    }
}

struct FlyingMuseum {            //CanFly
    func flyingDemo(flyingObject: Bird){ // w mesto tipa dannux Bird teper mi mogem ispolzowat CanFly protocol!!
        flyingObject.fly()
    }

}

struct Airplane: CanFly{
    func fly() {
        print("I can fly")
    }
    
    
}

let myEagle = Eagle()
myEagle.fly()
myEagle.layEgg()
myEagle.soap()
    

let myPenguin = Penguin()
myPenguin.layEgg()
myPenguin.swim()
myPenguin.fly()
    
let myPlane = Airplane()


let museum = FlyingMuseum()
museum.flyingDemo(flyingObject: myPlane)
