import UIKit

func loveCalculator (yourNama : String, theirName : String) -> String {

    let loveScore = Int.random(in: 0 ... 100)
    if loveScore > 80 {
         return "\(loveScore) % You real love her"
        
    }
    
    else if loveScore > 40 && loveScore <= 80 {
            return "\(loveScore) midle friends"
        }
    
    else {
        return "\(loveScore) % You dont love her"
    }
    
}

print (loveCalculator(yourNama: "name", theirName: "nameo"))

