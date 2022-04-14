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
    @IBOutlet private var heartImage: UIImageView!

    func configureCell(name: String, location: String, type: String, image: String, heartImageValue: Bool) {
        nameLabel.text = name
        locationLabel.text = location
        typeLabel.text = type
        thumbnailImageView.image = UIImage(named: image)
        heartImage.isHidden = !heartImageValue
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.tintColor = .systemYellow
    }
}
