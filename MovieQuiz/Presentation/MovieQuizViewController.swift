import UIKit

final class MovieQuizViewController: UIViewController {
    // MARK: - Lifecycle
    
    @IBOutlet private weak var counterLabel: UILabel!
    
    @IBOutlet private weak var imageView: UIImageView!
    
    @IBOutlet private weak var textLabel: UILabel!
    
    @IBOutlet private weak var yesButton: UIButton!
    
    @IBOutlet private weak var noButton: UIButton!
    
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
        
    private var presenter: MovieQuizPresenter!
    private var alertPresenter: AlertPresenterProtocol?
    private var statisticService: StatisticServiceProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alertPresenter = AlertPresenter(viewController: self)
        presenter = MovieQuizPresenter(viewController: self)
        statisticService = StatisticService()
    }
    
    @IBAction private func yesButtonClicked(_ sender: Any) {
        presenter.yesButtonClicked()
    }
    
    @IBAction private func noButtonClicked(_ sender: Any) {
        presenter.noButtonClicked()
    }
    
    func show(quiz step: QuizStepViewModel) {
        imageView.layer.borderWidth = 0
        counterLabel.text = step.questionNumber
        imageView.image = step.image
        textLabel.text = step.question
    }
    
    func showAnswerResult(isCorrect: Bool) {
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 8
        imageView.layer.borderColor = isCorrect ? UIColor.ypGreen.cgColor : UIColor.ypRed.cgColor
        yesButton.isEnabled = false
        noButton.isEnabled = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            guard let self = self else { return }
            self.presenter.showNextQuestionOrResults()
            self.yesButton.isEnabled = true
            self.noButton.isEnabled = true
        }
    }
}

extension MovieQuizViewController: StatisticServiceDelegate {
    
    func makeAlertMessage() -> String {
        guard
            let statisticService = statisticService,
            let bestGame = statisticService.bestGame else {
            assertionFailure("error message")
            return ""
        }
        let accuracy = String (format: "%.2f", statisticService.totalAccuracy)
        let totalPlaysCountLine = "Количество сыгранных квизов: \(statisticService.gamesCount) "
        let currentGameResultLine = "Ваш результат: \(presenter.correctAnswers) \\\(presenter.questionsAmount)"
        let bestGameInfoLine = "Рекорд: \(bestGame.correct)\\\(bestGame.total)"
        + " (\(bestGame.date.dateTimeString))"
        let averageAccuracyLine = "Средняя точность: \(accuracy)%"
        
        let resultMessage = [
            currentGameResultLine, totalPlaysCountLine, bestGameInfoLine, averageAccuracyLine ].joined (separator: "\n")
        
        return resultMessage
    }
}

extension MovieQuizViewController: AlertPresenterDelegate {
    
    func showFinalResults() {
        statisticService?.store(correct: presenter.correctAnswers, total: presenter.questionsAmount)
        
        let alertModel = AlertModel(title: "Игра окончена!",
                                    message: makeAlertMessage(),
                                    buttonText: "Сыграть заново!") { [weak self] in
            self?.presenter.restartGame()
        }
        alertPresenter?.show(alertModel: alertModel)
    }
    
    func showLoadingIndicator() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func hideLoadingIndicator() {
        activityIndicator.isHidden = true
    }
    
    func showNetworkError(message: String) {
        hideLoadingIndicator()
        
        let alertModel = AlertModel(title: "Oшибка",
                                    message: "",
                                    buttonText: "Попробовать еще раз") { [weak self] in
            self?.presenter.restartGame()
        }
        alertPresenter?.show(alertModel: alertModel)
    }
}
