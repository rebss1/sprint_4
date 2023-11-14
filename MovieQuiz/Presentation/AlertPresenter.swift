//
//  AlertPresenter.swift
//  MovieQuiz
//
//  Created by Илья Лощилов on 14.11.2023.
//

import Foundation
import UIKit

class AlertPresenter: AlertPresenterProtocol {
    weak var delegate: AlertPresenterDelegate?
    
    func configureAlert(quiz result: AlertModel) {
        let alert = UIAlertController(title: result.title, message: result.message, preferredStyle: .alert)
        let action = UIAlertAction(title: result.buttonText, style: .default) { _ in
            if result.completion != nil {
                result.completion!()
            }
        }
            alert.addAction(action)
            delegate?.alertPresent(alert: alert)
    }
}
