//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    let eggTimes = ["Soft": 300, "Medium": 420, "Hard": 720]
    var timer = Timer ()
    var totalTime = 0
    var secondPassed = 0
    var player: AVAudioPlayer?
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    
    
    // 1 sposob
    //    let softTime: Int = 5
    //
    //    let mediumTime: Int = 7
    //
    //    let hardTime: Int = 12
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        
        let hardness = sender.currentTitle!
        
        totalTime = eggTimes[hardness]!
        
        progressBar.progress = 0.0
        
        secondPassed = 0
        
        titleLabel.text = hardness
        
       timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    @objc func updateCounter() {
        
        if secondPassed < totalTime {
            secondPassed += 1
            progressBar.progress =  Float(secondPassed) / Float(totalTime)
           
        }
        else if secondPassed == totalTime{
            timer.invalidate()
            titleLabel.text = "DONE"
            
            playSound()
            
            let alert = UIAlertController(title: "Done", message: "Bon Appetit", preferredStyle: .alert)
            let restartAction = UIAlertAction(title: "OK", style: .default) { (restartActoin) in
                
            }
        
            alert.addAction(restartAction)
            self.present(alert, animated: true, completion: nil)
            
         
        }
    }
    
    func playSound(){
        
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")

                   do {
                       try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                       try AVAudioSession.sharedInstance().setActive(true)

                       player = try AVAudioPlayer(contentsOf: url!, fileTypeHint: AVFileType.mp3.rawValue)

                       player!.play()

                   } catch let error {
                       print(error.localizedDescription)
                   }
    }
}
    // 1 sposob
    //        switch hardness {
    //
    //        case "Hard":
    //            print(hardTime)
    //
    //        case "Medium":
    //            print(mediumTime)
    //
    //        case "Soft":
    //            print(softTime)
    //
    //        default:
    //            print("Error")
    //        }
    
    
    



