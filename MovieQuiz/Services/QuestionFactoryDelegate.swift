//
//  QuestionFactoryDelegate.swift
//  MovieQuiz
//
//  Created by Илья Лощилов on 13.11.2023.
//

import Foundation

protocol QuestionFactoryDelegate: AnyObject {
    func didReceiveNextQuestion(question: QuizQuestion?)
}
