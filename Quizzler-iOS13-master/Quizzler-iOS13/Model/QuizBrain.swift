//
//  Question.swift
//  Quizzler-iOS13
//
//  Created by Yurii Sameliuk on 17/10/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation
import AVFoundation

struct QuizBrain {
    
    var questionNumber = 0
    var score = 0
    var audioPlayer: AVAudioPlayer!
    
    let quiz = [
        Questoin(q: "Which is the largest organ in the human body?", a: ["Heart", "Skin", "Large Intestine"], correctAnswer: "Skin"),
        Questoin(q: "Five dollars is worth how many nickels?", a: ["25", "50", "100"], correctAnswer: "100"),
        Questoin(q: "What do the letters in the GMT time zone stand for?", a: ["Global Meridian Time", "Greenwich Mean Time", "General Median Time"], correctAnswer: "Greenwich Mean Time"),
        Questoin(q: "What is the French word for 'hat'?", a: ["Chapeau", "Écharpe", "Bonnet"], correctAnswer: "Chapeau"),
        Questoin(q: "In past times, what would a gentleman keep in his fob pocket?", a: ["Notebook", "Handkerchief", "Watch"], correctAnswer: "Watch"),
        Questoin(q: "How would one say goodbye in Spanish?", a: ["Au Revoir", "Adiós", "Salir"], correctAnswer: "Adiós"),
        Questoin(q: "Which of these colours is NOT featured in the logo for Google?", a: ["Green", "Orange", "Blue"], correctAnswer: "Orange"),
        Questoin(q: "What alcoholic drink is made from molasses?", a: ["Rum", "Whisky", "Gin"], correctAnswer: "Rum"),
        Questoin(q: "What type of animal was Harambe?", a: ["Panda", "Gorilla", "Crocodile"], correctAnswer: "Gorilla"),
        Questoin(q: "Where is Tasmania located?", a: ["Indonesia", "Australia", "Scotland"], correctAnswer: "Australia")
    ]
    
    
    mutating func checkAnswer(userAnswer: String) -> Bool {
       
        if userAnswer ==  quiz[questionNumber].correctAnswer {
            score += 1
            ProgressHUD.showSuccess("Correct!")
            playCorrectSound(soundName: "Correct")
            return true
        }
        else{
            playCorrectSound(soundName: "Wrong")
            ProgressHUD.showError("Wrong!")
            return false
        }
    }
    func getQuestionAnswer() -> [String]{
        return quiz[questionNumber].answer
        
    }
    func getQuestionText() -> String{
        return quiz[questionNumber].quesrion
    }
    
    func getProgress() -> Float{
        return Float(questionNumber) / Float(quiz.count)
        
    }
    
    mutating func nextQuestion(){
        if questionNumber + 1 < quiz.count{
            questionNumber += 1
        }
        else{
            questionNumber = 0
            score = 0
        }
    }
    func getScore() -> Int {
        return score
        
    }
    
    mutating func playCorrectSound(soundName: String) {
           
        let url = Bundle.main.url(forResource: soundName, withExtension:"mp3")
           
           audioPlayer = try! AVAudioPlayer(contentsOf: url!)

          audioPlayer.play()
        
    }
}
