//
//  RestaurantTableViewCell.swift
//  FoodPin
//
//  Created by Andreea Sburlea on 4/14/22.
//

import UIKit

class RestaurantTableViewCell: UITableViewCell {
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var locationLabel: UILabel!
    @IBOutlet private var typeLabel: UILabel!
    @IBOutlet private var thumbnailImageView: UIImageView!

    func configureCell(name: String, location: String, type: String, image: String) {
        nameLabel.text = name
        locationLabel.text = location
        typeLabel.text = type
        thumbnailImageView.image = UIImage(named: image)
    }
}
