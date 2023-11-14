//
//  AlertModel.swift
//  MovieQuiz
//
//  Created by Илья Лощилов on 14.11.2023.
//

import Foundation

struct AlertModel {
    let title: String
    let message: String
    let buttonText: String
    var completion: (() -> Void)?
}
