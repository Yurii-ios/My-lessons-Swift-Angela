//
//  Question.swift
//  Quizzler-iOS13
//
//  Created by Yurii Sameliuk on 17/10/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var Choise1: UIButton!
    
    @IBOutlet weak var Choise2: UIButton!
    
    @IBOutlet weak var Choise3: UIButton!
    
    var quizBrain = QuizBrain()
    var audioPlayer2: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    
    @IBAction func ChoiseAnswer(_ sender: UIButton) {
        
        let userAnswer = sender.currentTitle!
        
        let userItRight = quizBrain.checkAnswer(userAnswer: userAnswer)
        
        if  userItRight{
            
            sender.backgroundColor = UIColor.green
            
        }
        else{
            sender.backgroundColor = UIColor.red
        }
        
        quizBrain.nextQuestion()
        
        Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
        
    }
    
    @objc func updateUI(){
        Choise1.setTitle(quizBrain.getQuestionAnswer()[0], for: .normal)
        Choise2.setTitle(quizBrain.getQuestionAnswer()[1], for: .normal)
        Choise3.setTitle(quizBrain.getQuestionAnswer()[2], for: .normal)
        scoreLabel.text = "Score \(quizBrain.getScore())"
        questionLabel.text = quizBrain.getQuestionText()
        progressBar.progress = quizBrain.getProgress()
        Choise1.backgroundColor = UIColor.clear
        Choise2.backgroundColor = UIColor.clear
        Choise3.backgroundColor = UIColor.clear
        
        
    }
    
}
