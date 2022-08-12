//
//  EngageApp
//  Created by Luca Berardinelli
//

import Anchorage
import Combine
import UIKit

public class TransactionCell: BaseCell {
    private var viewModel: TransactionCellViewModel?
    private var cancellables = Set<AnyCancellable>()

    private lazy var containerView: UIView = {
        var view = UIView(frame: .zero)
        view.backgroundColor = .white
        view.layer.cornerRadius = 10

        return view
    }()

    private lazy var bodyView: UIView = {
        var view = UIView(frame: .zero)
        view.backgroundColor = .white
        view.layer.cornerRadius = 10

        return view
    }()

    private lazy var typeImgView: UIImageView = {
        let imgView = UIImageView(frame: .zero)
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()

    private lazy var typeLbl: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        LabelStyle.missionType.apply(to: label)
        label.textAlignment = .left
        label.numberOfLines = 0

        return label
    }()

    private lazy var textLbl: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        LabelStyle.missionText.apply(to: label)
        label.textAlignment = .left
        label.numberOfLines = 0

        return label
    }()

    private lazy var timeLbl: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        LabelStyle.missionTime.apply(to: label)
        label.textAlignment = .left
        label.numberOfLines = 0

        return label
    }()

    private lazy var coinsLbl: UILabel = {
        var label = UILabel()
        LabelStyle.missionCoins.apply(to: label)
        label.numberOfLines = 0

        return label
    }()

    private lazy var coinsImgView: UIImageView = {
        let imgView = UIImageView(frame: .zero)
        imgView.contentMode = .scaleAspectFill
        imgView.image = AppAsset.walletButton.image

        return imgView
    }()

    override public func configureUI() {
        super.configureUI()

        bodyView.addSubview(typeImgView)
        bodyView.addSubview(typeLbl)
        bodyView.addSubview(textLbl)
        bodyView.addSubview(timeLbl)
        bodyView.addSubview(coinsLbl)
        bodyView.addSubview(coinsImgView)

        containerView.addSubview(bodyView)
        addSubview(containerView)
    }

    override public func configureConstraints() {
        super.configureConstraints()

        containerView.edgeAnchors /==/ edgeAnchors

        bodyView.topAnchor /==/ containerView.topAnchor + 7
        bodyView.bottomAnchor /==/ containerView.bottomAnchor - 4
        bodyView.leadingAnchor /==/ containerView.leadingAnchor + 4
        bodyView.trailingAnchor /==/ containerView.trailingAnchor - 7

        typeImgView.centerYAnchor /==/ centerYAnchor
        typeImgView.leadingAnchor /==/ bodyView.leadingAnchor + 10
        typeImgView.heightAnchor /==/ 25
        typeImgView.widthAnchor /==/ typeImgView.heightAnchor

        typeLbl.topAnchor /==/ bodyView.topAnchor + 10
        typeLbl.leadingAnchor /==/ typeImgView.trailingAnchor + 15

        textLbl.topAnchor /==/ typeLbl.bottomAnchor + 2
        textLbl.leadingAnchor /==/ typeLbl.leadingAnchor
        textLbl.widthAnchor /==/ 250

        timeLbl.topAnchor /==/ textLbl.bottomAnchor + 2
        timeLbl.leadingAnchor /==/ typeLbl.leadingAnchor
        timeLbl.widthAnchor /==/ bodyView.widthAnchor
        timeLbl.bottomAnchor /==/ bodyView.bottomAnchor - 8

        coinsImgView.centerYAnchor /==/ bodyView.centerYAnchor
        coinsImgView.trailingAnchor /==/ bodyView.trailingAnchor - 10
        coinsImgView.heightAnchor /==/ 25
        coinsImgView.widthAnchor /==/ coinsImgView.heightAnchor

        coinsLbl.centerYAnchor /==/ coinsImgView.centerYAnchor
        coinsLbl.trailingAnchor /==/ coinsImgView.leadingAnchor - 5
    }

    override public func draw(_ rect: CGRect) {
        super.draw(rect)

        bodyView.layer.borderWidth = 1
        bodyView.layer.borderColor = UIColor.lightGray.cgColor
    }

    public func configureViewModel(viewModel: TransactionCellViewModel) {
        self.viewModel = viewModel

        configureBinds()
        viewModel.getInfo()
    }

    private func configureBinds() {
        viewModel?.$transactionCollectionViewCellState
            .sink(receiveValue: { state in
                switch state {
                case let .success(transaction):
                    self.refreshUI(transaction: transaction)
                default:
                    break
                }
            })
            .store(in: &cancellables)
    }

    private func refreshUI(transaction: WalletTransaction) {
        textLbl.text = transaction.title ?? "Premio riscattato"
        coinsLbl.text = "\(transaction.coins ?? 0)"
        Int(transaction.coins ?? 0) < 0 ? LabelStyle.walletCoinsSpent.apply(to: coinsLbl) : LabelStyle.walletCoinsEarned.apply(to: coinsLbl)

        /// transaction date
        let createdAt = Date(detectFromString: transaction.created_at ?? "")
        let transactionHour = Calendar.current.component(.hour, from: createdAt ?? Date())
        let transactionMinutes = Calendar.current.component(.minute, from: createdAt ?? Date())
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yy"
        let transactionDate = formatter.string(from: createdAt ?? Date())
        timeLbl.text = L10n.walletTransactionDate.replacingOccurrences(of: "%1", with: "\(transactionDate)")
            .replacingOccurrences(of: "%2", with: "\(transactionHour)")
            .replacingOccurrences(of: "%3", with: String(format: "%02d", transactionMinutes))

        switch MissionType(transaction.type ?? "") {
        case .quiz:
            typeLbl.text = L10n.missionTypeQuiz.uppercased()
            typeImgView.image = AppAsset.walletMissionOk.image
        case .survey:
            typeLbl.text = L10n.missionTypeSurvey.uppercased()
            typeImgView.image = AppAsset.walletMissionOk.image
        case .info:
            typeLbl.text = L10n.missionTypeInfo.uppercased()
            typeImgView.image = AppAsset.walletMissionOk.image
        case .fancam:
            typeLbl.text = L10n.missionTypeFancam.uppercased()
            typeImgView.image = AppAsset.walletMissionOk.image
        case .instantwin:
            typeLbl.text = L10n.missionTypeInstantwin.uppercased()
            typeImgView.image = AppAsset.walletMissionOk.image
        case .identityTouchpoint:
            typeLbl.text = L10n.missionTypeSocialFacebook.uppercased()
            typeImgView.image = AppAsset.walletMissionOk.image
        default:
            // reedem
            LabelStyle.walletCoinsSpent.apply(to: coinsLbl)
            typeImgView.image = AppAsset.walletRedeem.image
        }
    }

    override public func prepareForReuse() {
        typeImgView.image = nil
        typeLbl.text = ""
        textLbl.text = ""
    }
}
