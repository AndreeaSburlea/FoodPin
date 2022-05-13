//
//  WalkthroughViewController.swift
//  FoodPin
//
//  Created by Andreea Sburlea on 11.05.2022.
//

import UIKit

class WalkthroughViewController: UIViewController {

    @IBOutlet private var pageControl: UIPageControl!
    @IBOutlet private var skipButton: UIButton!
    @IBOutlet private var nextButton: UIButton! {
        didSet {
            nextButton.layer.cornerRadius = 25.0
            nextButton.layer.masksToBounds = true
        }
    }

    @IBAction private func skipButtonTapped(sender: UIButton) {
        UserDefaults.standard.set(true, forKey: "hasViewedWalkthrough")
        dismiss(animated: true, completion: nil)
    }

    @IBAction private func nextButtonTapped(sender: UIButton) {
        if let index = walkthroughPageViewController?.currentIndex {
            switch index {
            case 0...1:
                    walkthroughPageViewController?.forwardPage()
            case 2:
                    UserDefaults.standard.set(true, forKey: "hasViewedWalkthrough")
                    dismiss(animated: true, completion: nil)
            default: break
            }
        }

        updateUI()
    }

    var walkthroughPageViewController: WalkthroughPageViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination
        if let pageViewController = destination as? WalkthroughPageViewController {
            walkthroughPageViewController = pageViewController
            walkthroughPageViewController?.walkthroughDelegate = self
        }
    }

    func updateUI() {
        if let index = walkthroughPageViewController?.currentIndex {
            switch index {
            case 0...1:
                    nextButton.setTitle("NEXT", for: .normal)
                    skipButton.isHidden = false
            case 2:
                    nextButton.setTitle("GET STARTED", for: .normal)
                    skipButton.isHidden = true
            default: break
            }

            pageControl.currentPage = index
        }
    }
}

extension WalkthroughViewController: WalkthroughPageViewControllerDelegate {
    func didUpdatePageIndex(currentIndex: Int) {
        updateUI()
    }
}
