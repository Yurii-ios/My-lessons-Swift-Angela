//
//  Question.swift
//  Quizzler
//
//  Created by Yurii Sameliuk on 06/10/2019.
//

import Foundation

class  Question {
    
    let questionText : String
    let answer : Bool
    
    init (text: String, correctAnswer: Bool) {
        questionText = text
        answer = correctAnswer
    }
}



//
//class myOtherClass {
//
//    let questions = Question(text: <#T##String#>, correctAnswer: <#T##Bool#>)
//
//}
