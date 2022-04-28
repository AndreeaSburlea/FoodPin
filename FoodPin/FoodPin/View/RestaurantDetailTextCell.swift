//
//  RestaurantDetailTextCell.swift
//  FoodPin
//
//  Created by Andreea Sburlea on 28.04.2022.
//

import UIKit

class RestaurantDetailTextCell: UITableViewCell {

    @IBOutlet private var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.numberOfLines = 0
        }
    }

    func configureDescriptionCell(text: String) {
        descriptionLabel.text = text
    }
}
