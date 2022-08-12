//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation
import UIKit

protocol SurveyCollectionViewProtocol {
    func blockUI(blockUI: Bool, hide: Bool)

    var answerStkView: UIStackView { get set }
    var continueBtn: UIButton { get set }
    var msgTextView: UITextView { get set }
    var viewModel: SurveyCollectionViewViewModel? { get set }
}
