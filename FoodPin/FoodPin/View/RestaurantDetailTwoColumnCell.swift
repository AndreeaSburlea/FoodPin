//
//  RestaurantDetailTwoColumnCell.swift
//  FoodPin
//
//  Created by Andreea Sburlea on 28.04.2022.
//

import UIKit

class RestaurantDetailTwoColumnCell: UITableViewCell {

    @IBOutlet private var adressTitleLabel: UILabel! {
        didSet {
            adressTitleLabel.text = adressTitleLabel.text?.uppercased()
            adressTitleLabel.numberOfLines = 0
        }
    }

    func configureAdressTitleLabel(text: String) {
        adressTitleLabel.text = text
    }

    @IBOutlet private var adressTextLabel: UILabel! {
        didSet {
            adressTextLabel.numberOfLines = 0
        }
    }

    func configureAdressTextLabel(text: String) {
        adressTextLabel.text = text
    }

    @IBOutlet private var phoneTitleLabel: UILabel! {
        didSet {
            phoneTitleLabel.text = phoneTitleLabel.text?.uppercased()
            phoneTitleLabel.numberOfLines = 0
        }
    }

    func configurePhoneTitleLabel(text: String) {
        phoneTitleLabel.text = text
    }

    @IBOutlet private var phoneTextLabel: UILabel! {
        didSet {
            phoneTextLabel.numberOfLines = 0
        }
    }

    func configurePhoneTextLabel(text: String) {
        phoneTextLabel.text = text
    }
}
