//
//  ViewController.swift
//  RotateToDeprecate
//
//  Created by WJ on 15/11/3.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit
//import QuartzCore

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        print("1")

        let transitionToWide = size.width > size.height
        let image =  UIImage(named: transitionToWide ? "landscape_bg" :"portrait_bg" )
        
        coordinator.animateAlongsideTransition({ (context ) -> Void in
            let transition = CATransition()
            transition.duration = context.transitionDuration()
            
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            transition.type = kCATransitionFade
            self.imageView.layer.addAnimation(transition, forKey: "Fade")
            
            self.imageView.image = image
            }, completion: nil)
    }
    
    
    override func willTransitionToTraitCollection(newCollection: UITraitCollection, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        print("2")
    }
}

