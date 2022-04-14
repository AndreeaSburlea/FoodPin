//
//  SceneDelegate.swift
//  FoodPin
//
//  Created by Andreea Sburlea on 4/14/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    // swiftlint:disable line_length
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).guard scene is UIWindowScene else { return }
        guard scene is UIWindowScene else { return }
    }
}
