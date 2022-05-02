//
//  NavigationController.swift
//  FoodPin
//
//  Created by Andreea Sburlea on 02.05.2022.
//

import UIKit

class NavigationController: UINavigationController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }
}
