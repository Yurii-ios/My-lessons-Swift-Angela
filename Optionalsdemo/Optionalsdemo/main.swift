let myOptional: String?

myOptional = "Yurii"
// forse unrapping (optional!) - prenyditelnoe razwora4ivanie
let text: String = myOptional!

// Check for nil value  - proverka na nylewoe zna4enie
// if optional != nil{
//  optional!
// }
if myOptional != nil {
let text: String = myOptional!
}else{
    print("nil")
}

// Optional Binding - neobjazatelnaja proverka
// if let safeOptional = optional{
// safeOptional
// }


if let safeOptional = myOptional{
    let text: String = safeOptional
}
else{
    print("Nil")
}
 
// Nil Coalescing Operator - nylevoj operator obedinenija
// optional ?? defaultValue

let text: String = myOptional ?? "nil"

// Optional Chaining - neobjazatelnaja цепь
// optional?.property
// optional?.method()
struct MyOptional {
    var property = 123
    func method(){
        print("struct method")
    }
}
let myOptional: MyOptional?

myOptional = MyOptional()
print(myOptional?.property)


