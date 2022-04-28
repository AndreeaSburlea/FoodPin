//
//  RestaurantDetailViewController.swift
//  FoodPin
//
//  Created by Andreea Sburlea on 27.04.2022.
//

import UIKit

class RestaurantDetailViewController: UIViewController {

    @IBOutlet private var restaurantImageView: UIImageView!
    @IBOutlet private var restaurantName: UILabel!
    @IBOutlet private var restaurantType: UILabel!
    @IBOutlet private var restaurantLocation: UILabel!

    var restaurant: Restaurant!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.largeTitleDisplayMode = .never
        restaurantImageView.image = UIImage(named: restaurant.image)
        restaurantName.text = restaurant.name
        restaurantType.text = restaurant.type
        restaurantLocation.text = restaurant.location
    }
}
