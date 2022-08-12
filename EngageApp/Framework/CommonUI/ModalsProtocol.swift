//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation
import UIKit

// MARK: - Modable

public protocol Modable {
    func showModal(modalView: ModalView, fromCurrentContext: Bool)
    func hideModal(withAction: (() -> Void)?)
}

// MARK: - ModalView

public protocol ModalView: UIView {
    var type: ModalType { get set }
    var from: Modable { get set }
}

// MARK: - ModalType

public enum ModalType {
    case modalDialog
    case loader
}
