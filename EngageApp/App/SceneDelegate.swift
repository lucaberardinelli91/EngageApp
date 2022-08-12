//
//  EngageApp
//
//  Created by Luca Berardinelli
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var mainCoordinator: MainCoordinator?

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).

        let theme = Theme(
            barStyle: .default,
            primaryFont: CustomFont(stringLiteral: "OpenSans-Regular"),
            primaryBoldFont: CustomFont(stringLiteral: "OpenSans-Bold"),
            primaryMediumFont: CustomFont(stringLiteral: "OpenSans-ExtraBold"),
            primaryItalicFont: CustomFont(stringLiteral: "OpenSans-Italic"),

            secondary300: CustomFont(stringLiteral: "OpenSans-300"),
            secondary300Italic: CustomFont(stringLiteral: "OpenSans-300italic"),
            secondary600: CustomFont(stringLiteral: "OpenSans-600"),
            secondary600Italic: CustomFont(stringLiteral: "OpenSans-600italic"),
            secondary700: CustomFont(stringLiteral: "OpenSans-700"),
            secondary700Italic: CustomFont(stringLiteral: "OpenSans-700italic"),
            secondary800: CustomFont(stringLiteral: "OpenSans-800"),
            secondary800Italic: CustomFont(stringLiteral: "OpenSans-800italic")
        )

        let configurator = BaseConfigurator(baseURL: "https://www.google.it/",
                                            apiKey: "7n87387dnx8h3n8dh33nh48fdwcwfewfr",
                                            apiVersion: .v1,
                                            theme: theme)

        Configurator.setup(configurator: configurator)

        if let windowScene = scene as? UIWindowScene {
            window = UIWindow(windowScene: windowScene)

            mainCoordinator = MainCoordinator()
            mainCoordinator?.start()
            window?.rootViewController = mainCoordinator?.navigationController

            window?.makeKeyAndVisible()
        }

        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}
