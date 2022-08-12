//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation

extension BaseViewController: Modable {
    public func showModal(modalView: ModalView, fromCurrentContext: Bool = true) {
        modalViews.append(modalView)

        if fromCurrentContext {
            view.addSubview(modalView)
        }
        //      else if let frontWindow = UIWindow.frontWindow {
        //      frontWindow.addSubview(modalView)
        //    }
    }

    public func hideModal(withAction: (() -> Void)? = nil) {
        //    for window in UIApplication.shared.windows {
        //      for v in window.subviews {
        //        if
        //          modalViews.contains(where: { modalView -> Bool in
        //            v === modalView
        //          })
        //        {
        //          v.removeFromSuperview()
        //          modalViews.removeAll(where: { modalView -> Bool in
        //            v === modalView
        //          })
        //          v.removeFromSuperview()
        //          withAction?()
        //          break
        //        }
        //      }
        //    }

        for s in view.subviews {
            if
                modalViews.contains(where: { modalView -> Bool in
                    s === modalView
                })
            {
                s.removeFromSuperview()
                modalViews.removeAll(where: { modalView -> Bool in
                    s === modalView
                })
                s.removeFromSuperview()
                withAction?()
                break
            }
        }
    }
}
