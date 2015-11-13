//
//  OverlayPresentationController.swift
//  BouncyPresent
//
//  Created by WJ on 15/11/13.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit

class OverlayPresentationController: UIPresentationController {
    let dimmingView = UIView()
    
    override init(presentedViewController: UIViewController, presentingViewController: UIViewController) {
        super.init(presentedViewController: presentedViewController, presentingViewController: presentingViewController)
        dimmingView.backgroundColor = UIColor(white: 0, alpha: 0.5)
    }
    
    override func presentationTransitionWillBegin() {
        dimmingView.frame = containerView!.bounds
        dimmingView.alpha = 0
        containerView?.insertSubview(dimmingView, atIndex: 0)
        
        presentedViewController.transitionCoordinator()?.animateAlongsideTransition({ (context ) -> Void in
            self.dimmingView.alpha = 1.0
            }, completion: nil)
    }
    
    override func dismissalTransitionWillBegin() {
        presentedViewController.transitionCoordinator()?.animateAlongsideTransition({ (context ) -> Void in
            self.dimmingView.alpha = 0
            }, completion: { (context ) -> Void in
                self.dimmingView.removeFromSuperview()
        })
    }
    
    override func frameOfPresentedViewInContainerView() -> CGRect {
        return containerView!.bounds.insetBy(dx: 30, dy: 30)
    }
    
    override func containerViewWillLayoutSubviews() {
        dimmingView.frame = containerView!.bounds
        presentedView()!.frame = frameOfPresentedViewInContainerView()
    }
}
