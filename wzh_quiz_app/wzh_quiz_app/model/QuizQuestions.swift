//
//  QuizQuestions.swift
//  wzh_quiz_app
//
//  Created by SD on 13/03/2023.
//

import Foundation

struct QuizQuestion: Codable, Equatable {
    var category: QuizCategory
    var qaNumber: Int
    var question: String
    var answer: String
}

enum QuizCategory: String, Codable {
    case red // taal
    case green // natuur
    case blue // liedjes
    case yellow // allerlei
    case orange // spreekwoorden en gezegden
}
