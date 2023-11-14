//
//  AlertPresenter.swift
//  MovieQuiz
//
//  Created by Илья Лощилов on 14.11.2023.
//

import Foundation
import UIKit

class AlertPrresenter {
    let alert = UIAlertController(title: alertModel.title ,
                                  message: alertModel.text,
                                  preferredStyle: .alert)
    
    let action = UIAlertAction(title: alertModel.buttonText, style: .default) { [weak self] _ in
        guard let self = self else { return }
    }
}
