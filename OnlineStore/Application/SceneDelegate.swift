//
//  SceneDelegate.swift
//  OnlineStore
//
//  Created by Алиса Романова on 07.12.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = StoreTabBarController()
        window?.makeKeyAndVisible()
    }
}
