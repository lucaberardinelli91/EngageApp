//
//  EngageApp
//  Created by Luca Berardinelli
//

import Anchorage
import UIKit

public class FanCamInfoBS: BottomSheet {
    private lazy var triangleView: TriangleView = {
        let view = TriangleView(frame: CGRect(x: 10, y: 20, width: 25, height: 30))
        view.backgroundColor = .clear

        return view
    }()

    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white

        return view
    }()

    private let titleLbl: UILabel = {
        var label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        LabelStyle.fancamInfoTitle.apply(to: label)
        label.text = L10n.fancamInfoTitle

        return label
    }()

    var subtitleLbl: UILabel = {
        var label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .center
        LabelStyle.fancamInfoSubTitle.apply(to: label)
        label.numberOfLines = 0

        return label
    }()

    private let takePhotoLbl: UILabel = {
        var label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .center
        LabelStyle.fancamInfoTakePhoto.apply(to: label)
        label.text = L10n.fancamInfoTakePhoto
        label.numberOfLines = 0

        return label
    }()

    init() {
        super.init(height: 180)

        configureUI()
        configureConstraints()
    }

    override func configureUI() {
        super.configureUI()

        backgroundColor = .clear

        containerView.addSubview(titleLbl)
        containerView.addSubview(subtitleLbl)
        containerView.addSubview(takePhotoLbl)

        addSubview(triangleView)
        addSubview(containerView)
    }

    override func configureConstraints() {
        super.configureConstraints()

        containerView.topAnchor /==/ topAnchor + 7
        containerView.leadingAnchor /==/ leadingAnchor
        containerView.trailingAnchor /==/ trailingAnchor
        containerView.bottomAnchor /==/ bottomAnchor

        triangleView.topAnchor /==/ topAnchor
        triangleView.bottomAnchor /==/ containerView.topAnchor
        triangleView.centerXAnchor /==/ centerXAnchor
        triangleView.widthAnchor /==/ 20
        triangleView.heightAnchor /==/ triangleView.widthAnchor

        titleLbl.topAnchor /==/ containerView.topAnchor + 19
        titleLbl.centerXAnchor /==/ containerView.centerXAnchor

        subtitleLbl.topAnchor /==/ titleLbl.bottomAnchor + 7
        subtitleLbl.leftAnchor /==/ containerView.leftAnchor + 26
        subtitleLbl.rightAnchor /==/ containerView.rightAnchor - 26

        takePhotoLbl.bottomAnchor /==/ bottomAnchor - 15
        takePhotoLbl.centerXAnchor /==/ containerView.centerXAnchor
    }

    override public func layoutSubviews() {
        super.layoutSubviews()

        containerView.roundCorners(corners: [.topLeft, .topRight, .bottomLeft, .bottomRight], radius: 16)
    }
}

extension FanCamInfoBS: UITextViewDelegate {
    public func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == L10n.surveyPlaceholder {
            textView.text.removeAll()
            textView.textColor = AppAsset.grayOpaque.color
            textView.tintColor = AppAsset.grayOpaque.color
        }
    }

    public func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.textColor = UIColor.lightGray.color
            textView.tintColor = UIColor.lightGray.color
            textView.text = L10n.surveyPlaceholder
        }
    }
}
