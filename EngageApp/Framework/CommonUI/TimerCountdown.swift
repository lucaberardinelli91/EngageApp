//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

// MARK: - TimerCountdownDelegate

public protocol TimerCountdownDelegate: AnyObject {
    func onTimeout()
}

// MARK: - TimerCountdown

public class TimerCountdown {
    private var timer: Timer?
    public weak var delegate: TimerCountdownDelegate?

    private let dateCountdown: Date

    public init(dateCountdown: Date) {
        self.dateCountdown = dateCountdown.localDate()
    }

    public func getTimeCountDown(completionHandler: @escaping (Int, Int, Int, Int) -> Void) {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in

            let dateNow = Date().localDate()
            let calendar = Calendar.current
            let componentsNow = calendar.dateComponents([.hour, .minute, .month, .year, .day, .second], from: dateNow)
            let currentDate = calendar.date(from: componentsNow)

            let userCalendar = Calendar.current
            let componentsDateCountdown = calendar.dateComponents([.hour, .minute, .month, .year, .day, .second], from: self.dateCountdown)

            var competitionDate = DateComponents()
            competitionDate.year = componentsDateCountdown.year
            competitionDate.month = componentsDateCountdown.month
            competitionDate.day = componentsDateCountdown.day
            competitionDate.hour = componentsDateCountdown.hour
            competitionDate.minute = componentsDateCountdown.minute
            competitionDate.second = componentsDateCountdown.second
            let competitionDay = userCalendar.date(from: competitionDate)!

            let CompetitionDayDifference = calendar.dateComponents([.day, .hour, .minute, .second], from: currentDate!, to: competitionDay)

            var daysLeft = CompetitionDayDifference.day ?? 0
            var hoursLeft = CompetitionDayDifference.hour ?? 0
            var minutesLeft = CompetitionDayDifference.minute ?? 0
            var secondsLeft = CompetitionDayDifference.second ?? 0

            if daysLeft <= 0, hoursLeft <= 0, minutesLeft <= 0, secondsLeft <= 0 {
                daysLeft = 0
                hoursLeft = 0
                minutesLeft = 0
                secondsLeft = 0

                self.timer?.invalidate()
                self.timer = nil
                self.delegate?.onTimeout()
            }

            completionHandler(daysLeft, hoursLeft, minutesLeft, secondsLeft)
        }
    }
}
