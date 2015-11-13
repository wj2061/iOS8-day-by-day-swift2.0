//
//  ViewController.swift
//  BouncyPresent
//
//  Created by WJ on 15/11/13.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let overlayTransitioningDelegate = OverlayTransitioningDelegate()
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "bouncySegue" {
            let overlayVC = segue.destinationViewController
            prepareOverlayVC(overlayVC)
        }
    }
    
    
    @IBAction func handleBouncyPresentPressed(sender: UIButton) {
        let overlayVC = storyboard!.instantiateViewControllerWithIdentifier("overlayViewController")
        prepareOverlayVC(overlayVC)
        presentViewController(overlayVC, animated: true, completion: nil)
    }





    private func prepareOverlayVC(overlayVC:UIViewController){
        overlayVC.transitioningDelegate = overlayTransitioningDelegate
        overlayVC.modalPresentationStyle = .Custom
    }
}

