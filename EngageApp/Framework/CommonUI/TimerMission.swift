//
//  EngageApp
//  Created by Luca Berardinelli
//

import Anchorage
import Combine
import UIKit

public class TimerMission: BaseView {
    private lazy var timerLbl: UILabel = {
        var label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.textAlignment = .right

        return label
    }()

    private lazy var timerImgView: UIImageView = {
        let imgView = UIImageView(frame: .zero)
        imgView.image = AppAsset.timerMission.image
        imgView.contentMode = .scaleAspectFill
        imgView.isHidden = true

        return imgView
    }()

    var countdownTimer: TimerCountdown?

    var inLauncher: Bool = false
    var time: (Int, Int, Int, Int)? { didSet { didSetTime() }}
    var days = 0, hours = 0, minutes = 0, seconds = 0

    override public func configureUI() {
        super.configureUI()

        addSubview(timerLbl)
        addSubview(timerImgView)
    }

    override public func configureConstraints() {
        super.configureConstraints()

        timerImgView.trailingAnchor /==/ trailingAnchor
        timerImgView.widthAnchor /==/ 15
        timerImgView.heightAnchor /==/ timerImgView.widthAnchor

        timerLbl.centerYAnchor /==/ timerImgView.centerYAnchor
        timerLbl.leadingAnchor /==/ leadingAnchor
        timerLbl.trailingAnchor /==/ timerImgView.leadingAnchor - 5
    }

    func setExpiringTime(endDate: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")

        if let date = dateFormatter.date(from: endDate) {
            let components = date.get(.day, .month, .year)
            if let day = components.day, let month = components.month, let year = components.year {
                if year - Calendar.current.component(.year, from: Date()) <= 0 {
                    // mission with end date
                    let diffInSeconds = Calendar.current.dateComponents([.second], from: Date(), to: date).second ?? 0
                    if (diffInSeconds ?? 1) / 3600 < 24 {
                        // mission expires in less than 1 day
                        let expiringTime = Date.secondsToHoursMinutesSeconds(diffInSeconds ?? 0)
                        if expiringTime.0 > 0 || expiringTime.1 > 0 || expiringTime.2 > 0 {
                            self.isHidden = false
                            self.time = (0, expiringTime.0, expiringTime.1, expiringTime.2)
                        } else {
                            self.isHidden = true
                            self.time = nil
                        }
                    } else {
                        // mission expires expires in a few days
                        let expiringTime = Date.secondsToDaysHoursMinutes(diffInSeconds ?? 0)
                        if expiringTime.0 > 0 || expiringTime.1 > 0 || expiringTime.2 > 0 {
                            self.isHidden = false
                            self.time = (expiringTime.0, expiringTime.1, expiringTime.2, 0)
                        } else {
                            self.isHidden = true
                            self.time = nil
                        }
                    }
                }
            }
        }
    }

    private func didSetTime() {
        guard let time = time else { return }

        days = time.0
        hours = time.1
        minutes = time.2
        seconds = time.3

        timerImgView.isHidden = false

        if days == 0 {
            /// hours + minutes + seconds
            timerLbl.text = L10n.missionTimerHours
                .replacingOccurrences(of: "%0", with: "\(hours)")
                .replacingOccurrences(of: "%1", with: "\(minutes)")
                .replacingOccurrences(of: "%2", with: "\(seconds)")

            Timer.scheduledTimer(timeInterval: 1.0,
                                 target: self,
                                 selector: #selector(updateTimer),
                                 userInfo: nil,
                                 repeats: true)
        } else {
            /// days + hours + minutes
            timerLbl.text = L10n.missionTimerDays
                .replacingOccurrences(of: "%0", with: "\(days)")
                .replacingOccurrences(of: "%1", with: "\(hours)")
                .replacingOccurrences(of: "%2", with: "\(minutes)")

            Timer.scheduledTimer(timeInterval: 60.0,
                                 target: self,
                                 selector: #selector(updateTimer),
                                 userInfo: nil,
                                 repeats: true)
        }

        inLauncher ? LabelStyle.timerMissionLauncher.apply(to: timerLbl) : LabelStyle.timerMission.apply(to: timerLbl)
    }

    @objc func updateTimer() {
        if days == 0 {
            /// hours + minutes + seconds
            if seconds == 0 {
                if minutes == 0 {
                    if hours != 0 {
                        seconds = 59
                        minutes = 59
                        hours -= 1
                    }
                } else {
                    seconds = 59
                    minutes -= 1
                }
            } else {
                seconds -= 1
            }

            timerLbl.text = L10n.missionTimerHours
                .replacingOccurrences(of: "%0", with: "\(hours)")
                .replacingOccurrences(of: "%1", with: "\(minutes)")
                .replacingOccurrences(of: "%2", with: "\(seconds)")
        } else {
            /// days + hours + minutes
            if minutes == 0 {
                if hours == 0 {
                    if days != 0 {
                        minutes = 59
                        hours = 23
                        days -= 1
                    }
                } else {
                    minutes = 59
                    hours -= 1
                }
            } else {
                minutes -= 1
            }

            timerLbl.text = L10n.missionTimerDays
                .replacingOccurrences(of: "%0", with: "\(days)")
                .replacingOccurrences(of: "%1", with: "\(hours)")
                .replacingOccurrences(of: "%2", with: "\(minutes)")
        }
    }
}
