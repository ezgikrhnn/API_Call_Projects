//
//  QuestionModel.swift
//  QuizAppMVVM
//
//  Created by Ezgi Karahan on 15.01.2024.
//

import Foundation

struct DataModel : Codable {
    var data: QuestionModel?
}

struct QuestionModel : Codable{
    var questions: [Questions]?
}

struct Questions : Codable{
    var corrrect_answer : String?
    var option_1 : String?
    var option_2 : String?
    var option_3 : String?
    var option_4 : String?
    var question : String?
}
