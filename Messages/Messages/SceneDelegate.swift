//
//  SceneDelegate.swift
//  Messages
//
//  Created by Denis on 07.05.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    private let window = UIWindow(frame: UIScreen.main.bounds)
    private let rootViewController = UINavigationController()
    private let startViewController = MessagesViewController()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        rootViewController.addChild(startViewController)
        
        window.windowScene = windowScene
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
}

