//
//  PopoverViewController.swift
//  AppAlert
//
//  Created by WJ on 15/11/10.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit

class PopoverViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Popover from Code"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: "dismissPressed:")
    }


    
    @IBAction func dismissPressed(sender: UIButton) {
        presentingViewController?.dismissViewControllerAnimated(true , completion: nil)
    }


}
