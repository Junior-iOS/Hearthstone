//
//  SceneDelegate.swift
//  Hearthstone
//
//  Created by NJ Development on 18/07/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        let navigation = UINavigationController(rootViewController: HomeViewController())
        navigation.overrideUserInterfaceStyle = .dark
        window.rootViewController = navigation
        window.makeKeyAndVisible()
        self.window = window
    }
}
