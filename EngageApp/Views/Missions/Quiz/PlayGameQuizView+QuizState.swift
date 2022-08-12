//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation
import UIKit

enum QuizState {
    case idle
    case playing
    case answerSelected(answer: Answer)
    case timerToNextQuestion
}

extension PlayGameQuizView {
    func setIdle() {
        questionLbl.text = nil
        answerStkView.arrangedSubviews.forEach { view in
            view.removeFromSuperview()
        }
    }

    func setTimerToNextQuestion() {
        questionTimer?.invalidate()
        questionTimer = nil
        timerCircularProgress.stopAnimation()

        questionTime = 5
        questionTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            self.updateTime(isNext: true)
        })
        questionTimer?.fire()

        UIView.animate(withDuration: 0.5) {
            self.timerView.alpha = 1
            self.timerCircularProgress.alpha = 1

            self.timerCircularProgress.animate(fromAngle: 360, toAngle: 0, duration: TimeInterval(self.questionTime), completion: nil)
        }
    }

    func setAnswerSelected(answer: Answer) {
        guard let configurator = configurator else { return }

        answerStkView.arrangedSubviews.forEach { view in
            view.isUserInteractionEnabled = false
        }

        questionTimer?.invalidate()
        questionTimer = nil
        timerCircularProgress.stopAnimation()

        var timeToSend = 0

        if let maxTime = configurator.contest?.maxTimeSeconds, questionTime > 0 {
            timeToSend = maxTime - questionTime
        }

        questionTime = 0

        answerSelected.send((answer, timeToSend, configurator))
    }

    func setTimerToPlay() {
        guard let time = configurator?.contest?.maxTimeSeconds else { return }
        questionTime = time

        questionTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            self.updateTime(isNext: false)
        })
        questionTimer?.fire()

        UIView.animate(withDuration: 0.5) {
            self.timerView.alpha = 1
            self.timerCircularProgress.alpha = 1

            self.timerCircularProgress.animate(fromAngle: 360, toAngle: 0, duration: TimeInterval(time), completion: nil)
        }
    }

    private func updateTime(isNext: Bool) {
        questionTime >= 0 ? questionTime -= 1 : nil
        timerLbl.text = "\(questionTime)"

        if questionTime == 0 {
            questionTimer?.invalidate()
            questionTimer = nil
            questionTime = 0

            isNext ? timerExpired.send() : timerPlayExpired.send()
//            timerExpired.send()
        }
    }
}
