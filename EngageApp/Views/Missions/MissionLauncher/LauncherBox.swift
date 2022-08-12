//
//  EngageApp
//  Created by Luca Berardinelli
//

import Anchorage
import UIKit

enum LauncherInfoType {
    case plain
    case vertical
    case horizontal
}

public struct LauncherBoxInfo {
    let type: LauncherInfoType?
    let value: Int?
    var isInstantwin: Bool = false
}

public class LauncherBox: BaseView {
    private lazy var infoView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.borderColor = ThemeManager.currentTheme().secondaryColor.cgColor

        var timer = UILabel()
        timer.textAlignment = .center
        LabelStyle.launcherSubTitle.apply(to: timer)
        timer.numberOfLines = 0

        var sec = UILabel()
        sec.textAlignment = .center
        sec.text = "sec"
        LabelStyle.launcherDescription.apply(to: sec)
        sec.numberOfLines = 0

        view.addSubview(timer)
        view.addSubview(sec)

        timer.topAnchor /==/ view.topAnchor + 11
        timer.centerXAnchor /==/ view.centerXAnchor

        sec.topAnchor /==/ timer.bottomAnchor - 4
        sec.centerXAnchor /==/ timer.centerXAnchor

        return view
    }()

    private let infoLbl: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        LabelStyle.launcherBoxLabel.apply(to: label)
        label.numberOfLines = 0

        return label
    }()

    var launcherInfo: LauncherBoxInfo? { didSet { didSetLauncherInfo() }}

    override func configureUI() {
        super.configureUI()

        addSubview(infoView)
        addSubview(infoLbl)
    }

    override func configureConstraints() {
        super.configureConstraints()
    }

    override public func draw(_ rect: CGRect) {
        super.draw(rect)

        infoView.layer.cornerRadius = infoView.bounds.width / 2
    }

    private func didSetLauncherInfo() {
        guard let launcherInfo = launcherInfo, let value = launcherInfo.value else { return }

        (infoView.subviews[0] as! UILabel).text = "\(value)".formatValue()

        switch launcherInfo.type {
        case .plain:
            infoLbl.text = L10n.launcherQuestionsQuiz

            (infoView.subviews[1] as! UILabel).text = ""
            (infoView.subviews[0] as! UILabel).centerYAnchor == infoView.centerYAnchor

            infoView.topAnchor /==/ topAnchor
            infoView.centerXAnchor /==/ centerXAnchor
            infoView.widthAnchor /==/ 70
            infoView.heightAnchor /==/ infoView.widthAnchor

            infoLbl.topAnchor /==/ infoView.bottomAnchor + 5
            infoLbl.centerXAnchor /==/ centerXAnchor
            infoLbl.widthAnchor /==/ widthAnchor

        case .vertical:
            infoLbl.text = L10n.launcherTimerQuiz

            infoView.topAnchor /==/ topAnchor
            infoView.centerXAnchor /==/ centerXAnchor
            infoView.widthAnchor /==/ 70
            infoView.heightAnchor /==/ infoView.widthAnchor

            infoLbl.topAnchor /==/ infoView.bottomAnchor + 5
            infoLbl.centerXAnchor /==/ centerXAnchor
            infoLbl.widthAnchor /==/ widthAnchor

        case .horizontal:
            if launcherInfo.isInstantwin {
                infoLbl.text = L10n.launcherInstantWinCoins
                infoView.layer.borderColor = AppAsset.buttonCoins.color.cgColor
            } else {
                infoLbl.text = L10n.launcherQuestionsSurvey
            }

            (infoView.subviews[1] as! UILabel).text = ""
            (infoView.subviews[0] as! UILabel).centerYAnchor == infoView.centerYAnchor

            infoView.topAnchor /==/ topAnchor
            infoView.widthAnchor /==/ 70
            infoView.heightAnchor /==/ infoView.widthAnchor

            infoLbl.textAlignment = .left
            infoLbl.leadingAnchor /==/ infoView.trailingAnchor + 10
            infoLbl.centerYAnchor /==/ infoView.centerYAnchor
            infoLbl.widthAnchor /==/ 115

        default: break
        }
    }
}
