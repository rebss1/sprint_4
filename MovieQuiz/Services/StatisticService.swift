//
//  StatisticService.swift
//  MovieQuiz
//
//  Created by Илья Лощилов on 20.11.2023.
//

import Foundation

final class StatisticService {
    
    private enum Keys: String {
        case correct, total, bestGame, gamesCount
    }
    
    private let userDefaults: UserDefaults
    private var encoder: JSONEncoder
    private var decoder: JSONDecoder
    
    init(userDefaults: UserDefaults = .standard,
         encoder: JSONEncoder = JSONEncoder(),
         decoder: JSONDecoder = JSONDecoder()) {
        
        self.userDefaults = userDefaults
        self.encoder = encoder
        self.decoder = decoder
    }
}
extension StatisticService: StatisticServiceProtocol {
    
    var total: Int {
        get {
            userDefaults.integer(forKey: Keys.total.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Keys.total.rawValue)
        }
    }
    
    var correct: Int {
        get {
            userDefaults.integer(forKey: Keys.correct.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Keys.correct.rawValue)
        }
    }
    
    var totalAccuracy: Double {
        var totalAccuracy: Double = 0
        if total != 0 {
            totalAccuracy = Double(correct) / Double(total) * 100
        }
        return totalAccuracy
    }
    
    var gamesCount: Int {
        get {
            userDefaults.integer(forKey: Keys.gamesCount.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Keys.gamesCount.rawValue)
        }
    }
    
    var bestGame: BestGame? {
        get {
            guard
                let data = userDefaults.data(forKey: Keys.bestGame.rawValue),
                let bestGame = try? decoder.decode(BestGame.self, from: data) else {
                return .init(correct: 0, total: 0, date: Date())
            }
            return bestGame
        }
        set {
            guard let data = try? encoder.encode(newValue) else {
                print("Невозможно сохранить результат")
                return
            }
            userDefaults.set(data, forKey: Keys.bestGame.rawValue)
        }
    }
    
    func store(correct count: Int, total amount: Int) {
        self.correct += count
        self.total += amount
        self.gamesCount += 1
        
        let currentBestGame = BestGame(correct: count,
                                       total: amount,
                                       date: Date())
        
        if let previousBestGame = bestGame {
            if currentBestGame > previousBestGame {
                bestGame = currentBestGame
            }
        } else {
            bestGame = currentBestGame
        }
    }
}
