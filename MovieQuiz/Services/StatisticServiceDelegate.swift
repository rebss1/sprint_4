//
//  StatisticServiceDelegate.swift
//  MovieQuiz
//
//  Created by Илья Лощилов on 21.11.2023.
//

import Foundation

protocol StatisticServiceDelegate: AnyObject {
    func makeAlertMessage() -> String
}
