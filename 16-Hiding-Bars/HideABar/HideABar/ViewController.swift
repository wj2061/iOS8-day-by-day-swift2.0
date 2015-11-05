//
//  ViewController.swift
//  HideABar
//
//  Created by WJ on 15/11/5.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.hidesBarsOnTap = true
        navigationController?.hidesBarsOnSwipe = true
        navigationController?.hidesBarsWhenVerticallyCompact = true
        //add another action to the default SwipegestureRecognizer
        navigationController?.barHideOnSwipeGestureRecognizer.addTarget(self, action: "swipe:")
    }
    
    func swipe(gesture:UISwipeGestureRecognizer){
        print("swipe")
    }

 


}

