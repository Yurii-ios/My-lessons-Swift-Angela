//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
   let allQuestions = QuestionBank ()
   var pickedAnswer : Bool = false
   var questoinNumber : Int = 0
   var score : Int = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

       nextQuestion()
        
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        
        if sender.tag == 1 {
            pickedAnswer = true
            
        }
        else if sender.tag == 2 {
            pickedAnswer = false
            
        }
        checkAnswer()
        questoinNumber += 1
        nextQuestion()
        
  
    }
    
    
    func updateUI() {
        
        scoreLabel.text = " Score: \(score)"
        progressLabel.text = " \(questoinNumber + 1) / 13"
        progressBar.frame.size.width = (view.frame.size.width / 13) * CGFloat(questoinNumber )
        
    }
    

    func nextQuestion() {
        if questoinNumber <= 12 {
        questionLabel.text = allQuestions.list[questoinNumber].questionText
            updateUI()
        
    }
        else{
            let alert = UIAlertController(title: "Awesome", message: "You've finished all the questions,do you want to satrt over?", preferredStyle: .alert)
            let restartAction = UIAlertAction(title: "Restart", style: .default) { (restartActoin) in
                
            }
            self.startOver()
            alert.addAction(restartAction)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    func checkAnswer() {
        let correctAnswer = allQuestions.list[questoinNumber].answer
        
        if correctAnswer == pickedAnswer {
            print("You got it!")
            score += 1
            
        }
        else {
            print("wrong!")
        }
        
             }
    
    
    func startOver() {
       questoinNumber = 0
        nextQuestion()
        score = 0
        
    }
    

    
}
