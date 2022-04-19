//
//  RestaurantDiffableDataSource.swift
//  FoodPin
//
//  Created by Andreea Sburlea on 20.04.2022.
//

import UIKit

enum Section {
    case all
}

class RestaurantDiffableDataSource: UITableViewDiffableDataSource<Section, Restaurant> {
    // swiftlint:disable line_length
    // Make the cell editable and display the Delete button
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    }
}
