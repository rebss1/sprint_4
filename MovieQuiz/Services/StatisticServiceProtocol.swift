//
//  StatisticServiceProtocol.swift
//  MovieQuiz
//
//  Created by Илья Лощилов on 21.11.2023.
//

import Foundation

protocol StatisticServiceProtocol {
    var totalAccuracy: Double { get }
    var gamesCount: Int { get }
    var bestGame: BestGame? { get }
    
    func store(total amount: Int)
}
