//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation
import UIKit

open class BaseCell: UICollectionViewCell {
    override open func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureConstraints()
    }

    @available(*, unavailable)
    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureUI() {}

    func configureConstraints() {}

    override open func layoutSubviews() {
        super.layoutSubviews()
    }
}
