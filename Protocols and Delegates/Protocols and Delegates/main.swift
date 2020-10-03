
protocol AdvancedLifeSupport {
    func performCPR()
}

class EmergencyCallHandler {
    var delegate: AdvancedLifeSupport?
    
    func assessSituation(){
        print("Can you tell me wtat happened?")
    }
    
    func medicalEmergency(){
        delegate?.performCPR()
    }
}

struct Paramedic: AdvancedLifeSupport {
    
    init(handler: EmergencyCallHandler) {
        handler.delegate = self
    }
    
    func performCPR() {
        print("The paramidic does chest compression 30 per sec")
    }
    
    
}

class Doctor: AdvancedLifeSupport {
    
    init(handler: EmergencyCallHandler) {
        handler.delegate = self
    }
    func performCPR() {
        print("The doctor does chest compression 30 per sec")
    }
    
    func useStethescope(){
        print("Listening for heart sounds")
    }
    
}

class Surgeon: Doctor {
    override func performCPR() {
        super.performCPR()
        print("Sing staying alive by the BeeGees")
    }
    
    func useElectricDrill(){
        print("Whirrr...")
    }
}

let emilio = EmergencyCallHandler()
let pete = Paramedic (handler: emilio)

emilio.assessSituation()
emilio.medicalEmergency()
