//
//  AlertPresenterDelegate.swift
//  MovieQuiz
//
//  Created by Илья Лощилов on 14.11.2023.
//

import Foundation
import UIKit

protocol AlertPresenterDelegate: AnyObject {
    func alertPresent(alert: UIViewController)
}
