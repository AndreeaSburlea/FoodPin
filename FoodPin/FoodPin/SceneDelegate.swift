//
//  SceneDelegate.swift
//  FoodPin
//
//  Created by Andreea Sburlea on 4/14/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    // swiftlint:disable line_length

    enum QuickAction: String {
        case openFavorites = "OpenFavorites"
        case openDiscover = "OpenDiscover"
        case newRestaurant = "NewRestaurant"

        init?(fullIdentifier: String) {
            guard let shortcutIdentifier = fullIdentifier.components(separatedBy: ".").last else {
                return nil
            }
            self .init(rawValue: shortcutIdentifier)
        }
    }

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).guard scene is UIWindowScene else { return }
        guard scene is UIWindowScene else { return }
    }

    func windowScene(_ windowScene: UIWindowScene, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
            completionHandler(handleQuickAction(shortcutItem: shortcutItem))

    }

    private func handleQuickAction(shortcutItem: UIApplicationShortcutItem) -> Bool {
        let shortcutType = shortcutItem.type
        guard let shortcutIdentifier = QuickAction(fullIdentifier: shortcutType) else {
            return false
        }

        guard let tabBarController = window?.rootViewController as? UITabBarController else {
            return false
        }
        switch shortcutIdentifier {
        case .openFavorites:
                tabBarController.selectedIndex = 0
        case .openDiscover:
                tabBarController.selectedIndex = 1
        case .newRestaurant:
                if let navController = tabBarController.viewControllers?[0] {
                    let restaurantTableViewController = navController.children[0]
                    restaurantTableViewController.performSegue(withIdentifier: "addRestaurant", sender: restaurantTableViewController)
                } else {

                    return false
                }
        }

        return false
    }
}
