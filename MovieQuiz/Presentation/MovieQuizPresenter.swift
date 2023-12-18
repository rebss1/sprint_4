//
//  MovieQuizPresenter.swift
//  MovieQuiz
//
//  Created by Илья Лощилов on 17.12.2023.
//

import Foundation
import UIKit

final class MovieQuizPresenter {
    let questionsAmount: Int = 10
    private var currentQuestionIndex: Int = 0
    var correctAnswers = 0

    var currentQuestion: QuizQuestion?
    var questionFactory: QuestionFactoryProtocol?
    weak var viewController: MovieQuizViewController?
        
    init(viewController: MovieQuizViewController) {
        self.viewController = viewController
            
        questionFactory = QuestionFactory(moviesLoader: MoviesLoader(), delegate: self)
        questionFactory?.loadData()
        viewController.showLoadingIndicator()
    }
    
    func isLastQuestion() -> Bool {
        currentQuestionIndex == questionsAmount - 1
    }
    
    func restartGame() {
        currentQuestionIndex = 0
        correctAnswers = 0
        self.questionFactory?.requestNextQuestion()
    }
    
    func switchToNextQuestion() {
        currentQuestionIndex += 1
    }
    
    func convert(model: QuizQuestion) -> QuizStepViewModel {
        QuizStepViewModel(
            image: UIImage(data: model.image) ?? UIImage(),
            question: model.text,
            questionNumber: "\(currentQuestionIndex + 1 )/\(questionsAmount)")
    }
    
    func yesButtonClicked() {
        didAnswer(isCorrectAnswer: true)
    }
    
    func noButtonClicked() {
        didAnswer(isCorrectAnswer: false)
    }
    
    func didAnswer(isCorrectAnswer: Bool) {
        guard let currentQuestion = currentQuestion else {
            return
        }
        
        let givenAnswer = isCorrectAnswer
        
        viewController?.showAnswerResult(isCorrect: givenAnswer == currentQuestion.correctAnswer)
        
        if (isCorrectAnswer) { correctAnswers += 1 }
    }
    
    func showNextQuestionOrResults() {
        if self.isLastQuestion() {
            viewController?.showFinalResults()
        } else {
            self.switchToNextQuestion()
            questionFactory?.requestNextQuestion()
        }
    }
}

extension MovieQuizPresenter: QuestionFactoryDelegate {
    func didReceiveNextQuestion(question: QuizQuestion?) {
        guard let question = question else {
            return
        }
        
        currentQuestion = question
        let viewModel = convert(model: question)
        DispatchQueue.main.async { [weak self] in
            self?.viewController?.show(quiz: viewModel)
        }
    }
    
    func didLoadDataFromServer() {
        viewController?.hideLoadingIndicator()
        questionFactory?.requestNextQuestion()
    }
    
    func didFailToLoadData(with error: Error) {
        viewController?.showNetworkError(message: error.localizedDescription)
    }
}
