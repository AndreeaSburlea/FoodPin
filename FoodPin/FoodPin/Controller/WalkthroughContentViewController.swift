//
//  WalkthroughContentViewController.swift
//  FoodPin
//
//  Created by Andreea Sburlea on 11.05.2022.
//

import UIKit

class WalkthroughContentViewController: UIViewController {

    @IBOutlet private var headingLabel: UILabel! {
        didSet {
            headingLabel.numberOfLines = 0
        }
    }

    @IBOutlet private var subHeadingLabel: UILabel! {
        didSet {
            subHeadingLabel.numberOfLines = 0
        }
    }

    @IBOutlet private var contentImageView: UIImageView!

    var index = 0
    var heading = ""
    var subHeading = ""
    var imageFile = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        headingLabel.text = heading
        subHeadingLabel.text = subHeading
        contentImageView.image = UIImage(named: imageFile)
    }
}
