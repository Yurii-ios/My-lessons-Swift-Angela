//
//  Question.swift
//  Quizzler-iOS13
//
//  Created by Yurii Sameliuk on 17/10/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

struct Questoin {
    
    let quesrion: String
    let answer: [String]
    let correctAnswer: String
    
    init (q: String, a: [String], correctAnswer: String) {
        quesrion = q
        answer = a
        self.correctAnswer = correctAnswer
    }
}
