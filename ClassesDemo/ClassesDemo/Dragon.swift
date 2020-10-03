
class Dragon: Enemy {
    var windSpan = 2
    
    func talk(speech: String){
        print("Says \(speech)")
    }
    
    override func move() {
        print("Fly Forwards")
    }
    
    override func attack() {
        super .attack()
        print("Spits Fire, does 10 damage.")
      
    }
}
