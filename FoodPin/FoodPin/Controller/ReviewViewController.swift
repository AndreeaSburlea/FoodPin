//
//  ReviewViewController.swift
//  FoodPin
//
//  Created by Andreea Sburlea on 05.05.2022.
//

import UIKit

class ReviewViewController: UIViewController {

    @IBOutlet private var backgroundImageView: UIImageView!
    @IBOutlet private var closeButton: UIButton!
    @IBOutlet private var rateButtons: [UIButton]!

    var restaurant: Restaurant!

    override func viewDidLoad() {
        super.viewDidLoad()

        backgroundImageView.image = UIImage(data: restaurant.image)

        // Applying the blur effect
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)

        let moveRightTransform = CGAffineTransform.init(translationX: 600, y: 0)
        let scaleUpTransform = CGAffineTransform.init(scaleX: 5.0, y: 5.0)
        let moveScaleTransform = scaleUpTransform.concatenating(moveRightTransform)
        let moveUpTransform = CGAffineTransform.init(translationX: 0, y: -100)

        // Make button invisible
        for rateButton in rateButtons {
            rateButton.transform = moveScaleTransform
            rateButton.alpha = 0
        }

        closeButton.transform = moveUpTransform
        closeButton.alpha = 0
    }

    override func viewWillAppear(_ animated: Bool) {
        var delay = 0.1
        for rateButton in rateButtons {
            UIView.animate(withDuration: 0.4, delay: delay, options: [], animations: {
                rateButton.alpha = 1.0
                rateButton.transform = .identity
            }, completion: nil)
            delay += 0.05
        }

        UIView.animate(withDuration: 0.4, delay: 0.1, options: [], animations: {
            self.closeButton.alpha = 1.0
            self.closeButton.transform = .identity
        }, completion: nil)
    }
}
