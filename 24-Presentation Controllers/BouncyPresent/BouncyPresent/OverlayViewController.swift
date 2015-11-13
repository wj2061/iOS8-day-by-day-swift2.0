//
//  OverlayViewController.swift
//  BouncyPresent
//
//  Created by WJ on 15/11/13.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit

class OverlayViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.blackColor().CGColor
        view.layer.shadowOffset = CGSizeMake(0, 0)
        view.layer.shadowRadius = 10
        view.layer.shadowOpacity = 0.5

    }

    @IBAction func handleDismissedPressed(sender: UIButton) {
        presentingViewController?.dismissViewControllerAnimated(true , completion: nil)
    }
}
