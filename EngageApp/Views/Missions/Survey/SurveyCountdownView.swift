//
//  EngageApp
//  Created by Luca Berardinelli
//

import Anchorage
import Foundation
import SDWebImage

public class SurveyCountdownView: BaseView {
    private var configurator: Date? {
        didSet {
            configureUI()
            configureConstraints()
        }
    }

    var countdownTimer: TimerCountdown?
    var countDownReached: (() -> Void)?

    var countdownStkView: UIStackView = {
        var stackView = UIStackView(frame: .zero)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually

        return stackView
    }()

    var daysValueLbl: UILabel = {
        var label = UILabel(frame: .zero)
        label.textAlignment = .center
        LabelStyle.quizCountdownValueLabel.apply(to: label)

        return label
    }()

    var hoursValueLbl: UILabel = {
        var label = UILabel(frame: .zero)
        label.textAlignment = .center
        LabelStyle.quizCountdownValueLabel.apply(to: label)

        return label
    }()

    var minutesValueLbl: UILabel = {
        var label = UILabel(frame: .zero)
        label.textAlignment = .center
        LabelStyle.quizCountdownValueLabel.apply(to: label)

        return label
    }()

    var secondsValueLbl: UILabel = {
        var label = UILabel(frame: .zero)
        label.textAlignment = .center
        LabelStyle.quizCountdownValueLabel.apply(to: label)

        return label
    }()

    var daysLbl: UILabel = {
        var label = UILabel(frame: .zero)
        label.text = L10n.timerDays
        label.textAlignment = .center
        LabelStyle.quizCountdownLabel.apply(to: label)

        return label
    }()

    var hoursLbl: UILabel = {
        var label = UILabel(frame: .zero)
        label.text = L10n.timerHours
        label.textAlignment = .center
        LabelStyle.quizCountdownLabel.apply(to: label)

        return label
    }()

    var minutesLbl: UILabel = {
        var label = UILabel(frame: .zero)
        label.text = L10n.timerMinutes
        label.textAlignment = .center
        LabelStyle.quizCountdownLabel.apply(to: label)

        return label
    }()

    var secondsLbl: UILabel = {
        var label = UILabel(frame: .zero)
        label.text = L10n.timerSeconds
        label.textAlignment = .center
        LabelStyle.quizCountdownLabel.apply(to: label)

        return label
    }()

    var daysStkView: UIStackView = {
        var stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally

        return stackView
    }()

    var hoursStkView: UIStackView = {
        var stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally

        return stackView
    }()

    var minutesStkView: UIStackView = {
        var stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally

        return stackView
    }()

    var secondsStkView: UIStackView = {
        var stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally

        return stackView
    }()

    var daysSeparatorLbl: UILabel = {
        var label = UILabel(frame: .zero)
        label.text = "·"
        label.textAlignment = .center
        LabelStyle.nextMatchCountdownSeparator.apply(to: label)

        return label
    }()

    var hoursSeparatorLbl: UILabel = {
        var label = UILabel(frame: .zero)
        label.text = ":"
        label.textAlignment = .center
        LabelStyle.nextMatchCountdownSeparator.apply(to: label)

        return label
    }()

    var minutesSeparatorLbl: UILabel = {
        var label = UILabel(frame: .zero)
        label.text = ":"
        label.textAlignment = .center
        LabelStyle.nextMatchCountdownSeparator.apply(to: label)

        return label
    }()

    override func configureUI() {
        super.configureUI()

        layer.cornerRadius = 10
        layer.masksToBounds = true

        backgroundColor = .clear
        daysStkView.addArrangedSubview(daysValueLbl)
        daysStkView.addArrangedSubview(daysLbl)

        hoursStkView.addArrangedSubview(hoursValueLbl)
        hoursStkView.addArrangedSubview(hoursLbl)

        minutesStkView.addArrangedSubview(minutesValueLbl)
        minutesStkView.addArrangedSubview(minutesLbl)

        secondsStkView.addArrangedSubview(secondsValueLbl)
        secondsStkView.addArrangedSubview(secondsLbl)

        countdownStkView.addArrangedSubview(daysStkView)
        countdownStkView.addArrangedSubview(daysSeparatorLbl)
        countdownStkView.addArrangedSubview(hoursStkView)
        countdownStkView.addArrangedSubview(hoursSeparatorLbl)
        countdownStkView.addArrangedSubview(minutesStkView)

        countdownStkView.addArrangedSubview(minutesSeparatorLbl)
        addSubview(countdownStkView)

        guard let date = configurator else { return }
        countdownTimer = TimerCountdown(dateCountdown: date)
        updateCountdown()

        minutesSeparatorLbl.blink()
        hoursSeparatorLbl.blink()
        daysSeparatorLbl.blink()

        countdownTimer?.delegate = self
    }

    override func configureConstraints() {
        super.configureConstraints()

        countdownStkView.edgeAnchors /==/ edgeAnchors
    }

    override public func layoutSubviews() {
        super.layoutSubviews()

        minutesSeparatorLbl.layer.removeAllAnimations()
        hoursSeparatorLbl.layer.removeAllAnimations()
        daysSeparatorLbl.layer.removeAllAnimations()

        minutesSeparatorLbl.blink()
        hoursSeparatorLbl.blink()
        daysSeparatorLbl.blink()
    }

    public func setConfigurator(configurator: Date) {
        self.configurator = configurator
    }

    private func updateCountdown() {
        DispatchQueue.main.async {
            self.countdownTimer?.getTimeCountDown { days, hours, minutes, seconds in
                if days > 0 {
                    self.countdownStkView.removeFullyAllArrangedSubviews()

                    self.countdownStkView.addArrangedSubview(self.daysStkView)
                    self.countdownStkView.addArrangedSubview(self.daysSeparatorLbl)
                    self.countdownStkView.addArrangedSubview(self.hoursStkView)
                    self.countdownStkView.addArrangedSubview(self.hoursSeparatorLbl)
                    self.countdownStkView.addArrangedSubview(self.minutesStkView)
                } else {
                    self.countdownStkView.arrangedSubviews.forEach { view in
                        view.removeFromSuperview()
                    }

                    self.countdownStkView.addArrangedSubview(self.hoursStkView)
                    self.countdownStkView.addArrangedSubview(self.hoursSeparatorLbl)
                    self.countdownStkView.addArrangedSubview(self.minutesStkView)
                    self.countdownStkView.addArrangedSubview(self.minutesSeparatorLbl)
                    self.countdownStkView.addArrangedSubview(self.secondsStkView)
                }

                self.daysValueLbl.text = "\(String(format: "%02d", days))"
                self.hoursValueLbl.text = "\(String(format: "%02d", hours))"
                self.minutesValueLbl.text = "\(String(format: "%02d", minutes))"
                self.secondsValueLbl.text = "\(String(format: "%02d", seconds))"
            }
        }
    }
}

extension SurveyCountdownView: TimerCountdownDelegate {
    public func onTimeout() {
        countDownReached?()
    }
}
