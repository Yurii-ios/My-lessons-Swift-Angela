//
//  ViewController.swift
//  Dicee
//
//  Created by Yurii Sameliuk on 26/09/2019.
//  Copyright © 2019 Yurii Sameliuk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let diceArray = ["dice1","dice2","dice3","dice4","dice5","dice6"]
    
    var randomDiceIndex1: Int = 0
    var randomDiceIndex2: Int = 0
//
//    var leftButton : Int = 1
//    var rightButton : Int = 5
    
    @IBOutlet weak var diceImageView1: UIImageView!
    @IBOutlet weak var diceImageView2: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
      // WHO     .       WHAT =  VALUE
//        diceImageView1.image = #imageLiteral(resourceName: "dice2")  // image.literal
//
//        diceImageView2.image = #imageLiteral(resourceName: "dice5")
//
//        diceImageView1.alpha = 0.5
        
        updateDiceImages()
    }
    
    @IBAction func rollButtonPressed(_ sender: UIButton) {
        
        updateDiceImages()
        
    }
     
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        updateDiceImages()
    }
    
    func updateDiceImages(){
        randomDiceIndex1 = Int.random(in: 0 ... 5)
        randomDiceIndex2 = Int.random(in: 0 ... 5)
        diceImageView1.image = UIImage(named: diceArray[randomDiceIndex1])
        diceImageView2.image = UIImage(named: diceArray[randomDiceIndex2])
        
//        diceImageView1.image = [ #imageLiteral(resourceName: "dice1"), #imageLiteral(resourceName: "dice2"), #imageLiteral(resourceName: "dice3"), #imageLiteral(resourceName: "dice4"), #imageLiteral(resourceName: "dice5"), #imageLiteral(resourceName: "dice6") ]  [leftButton ]
//
//        diceImageView2.image =  [ #imageLiteral(resourceName: "dice1"), #imageLiteral(resourceName: "dice2"), #imageLiteral(resourceName: "dice3"), #imageLiteral(resourceName: "dice4"), #imageLiteral(resourceName: "dice5"), #imageLiteral(resourceName: "dice6")] [rightButton ]
//
//        leftButton = leftButton + 1
//
//        rightButton = rightButton - 1
               
    }
    
}

