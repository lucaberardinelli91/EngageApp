//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation
import UIKit

/// This class is a subclass of `BaseViewController` with two generics classes, an `UIView` and a `BaseViewModel`, that will be incorporated in this class
open class BasePackedViewController<View: UIView, ViewModel: BaseViewModel>: BaseViewController {
    public var _view: View {
        guard let view = view as? View else { preconditionFailure("Unable to cast view to \(View.self)") }
        return view
    }

    public let viewModel: ViewModel

    override public func loadView() {
        view = View()
    }

    public init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
