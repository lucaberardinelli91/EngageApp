//
//  EngageApp
//  Created by Luca Berardinelli
//

import Foundation
import UIKit

// MARK: - MailHelper

public class MailHelper: NSObject {
    public static let shared = MailHelper()

    // MARK: Properties

    private let clients: [MailClient]

    // MARK: Initialization

    public init(clients: [MailClient] = .all) {
        self.clients = clients.filter { UIApplication.shared.canOpenURL($0.url) }
    }

    // MARK: Methods

    public func present(from presenter: UIViewController) {
        guard !clients.isEmpty else {
            return
        }

        guard clients.count != 1 else {
            let appURL = URL(string: "mailto:assistenza@test.com")!
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(appURL)
            }
//            UIApplication.shared.open(clients[0].url, options: [:], completionHandler: nil)
            return
        }

        presenter.present(makeAlertController(), animated: true, completion: nil)
    }

    private func makeAlertController() -> UIAlertController {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        makeAlertActionsForAvailableClients().forEach(alertController.addAction)
        alertController.addAction(.init(title: "Annulla", style: .cancel, handler: nil))
        return alertController
    }

    private func makeAlertActionsForAvailableClients(using app: UIApplication = .shared) -> [UIAlertAction] {
        clients.map { client in
            UIAlertAction(title: client.name, style: .default) { _ in
                app.open(client.url, options: [:], completionHandler: nil)
            }
        }
    }
}

// MARK: - MailClient

public struct MailClient {
    // MARK: Constants

    static let mail: Self = .init(name: "Mail", scheme: "message://")

    static let spark: Self = .init(name: "Spark", scheme: "readdle-spark://")

    static let gmail: Self = .init(name: "Gmail", scheme: "googlegmail://")

    static let outlook: Self = .init(name: "Outlook", scheme: "ms-outlook://")

    // MARK: Properties

    let name: String

    let url: URL

    // MARK: Initialization

    public init(name: String, scheme: String) {
        self.name = name
        url = URL(string: scheme)!
    }
}

// MARK: - Array

public extension Array where Element == MailClient {
    static let all: Self = [.mail, .spark, .gmail, .outlook]
}
