//
//  RestaurantDetailViewController.swift
//  FoodPin
//
//  Created by Andreea Sburlea on 27.04.2022.
//

import UIKit

class RestaurantDetailViewController: UIViewController {
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var headerView: RestaurantDetailHeaderView!

    var restaurant: Restaurant!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false

        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none

        // Configure header view
        headerView.configureHeader(restaurant: restaurant)
    }
}
