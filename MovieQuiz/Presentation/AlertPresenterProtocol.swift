//
//  AlertPresenterProtocol.swift
//  MovieQuiz
//
//  Created by Илья Лощилов on 14.11.2023.
//

import Foundation

protocol AlertPresenterProtocol {
    var delegate: AlertPresenterDelegate? { get set }
    func configureAlert(quiz: AlertModel)
}
