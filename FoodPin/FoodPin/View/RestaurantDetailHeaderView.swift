//
//  RestaurantDetailHeaderView.swift
//  FoodPin
//
//  Created by Andreea Sburlea on 28.04.2022.
//

import UIKit

class RestaurantDetailHeaderView: UIView {
    @IBOutlet private var headerImageView: UIImageView!
    @IBOutlet private var ratingImageView: UIImageView!
    @IBOutlet private var heartButton: UIButton!
    @IBOutlet private var nameLabel: UILabel! {
        didSet {
            nameLabel.numberOfLines = 0

            if let customFont = UIFont(name: "Nunito-Bold", size: 40.0) {
                nameLabel.font = UIFontMetrics(forTextStyle: .title1).scaledFont(for: customFont)
            }
        }
    }

    @IBOutlet private var typeLabel: UILabel! {
        didSet {
            if let customFont = UIFont(name: "Nunito-Bold", size: 20.0) {
                typeLabel.font = UIFontMetrics(forTextStyle: .headline).scaledFont(for: customFont)
            }
        }
    }

    private var restaurant: Restaurant!

    func configureHeader(restaurant: Restaurant) {
        headerImageView.image = UIImage(named: restaurant.image)
        let heartImage = restaurant.isFavorite ? "heart.fill" : "heart"
        heartButton.setImage(UIImage(systemName: heartImage), for: .normal)
        heartButton.tintColor = restaurant.isFavorite ? .systemYellow : .white
        nameLabel.text = restaurant.name
        typeLabel.text = restaurant.type
    }

    func setRatingImage(imageRating: String) {
        ratingImageView.image = UIImage(named: imageRating)
    }

    func configureRatingImage(transform: CGAffineTransform, alpha: CGFloat) {
        ratingImageView.transform = transform
        ratingImageView.alpha = alpha
    }
}
