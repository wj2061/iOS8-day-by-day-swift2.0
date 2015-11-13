//
//  BouncyViewControllerAnimator.swift
//  BouncyPresent
//
//  Created by WJ on 15/11/13.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit

class BouncyViewControllerAnimator: NSObject ,UIViewControllerAnimatedTransitioning{

    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.8
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        if let presentedView = transitionContext.viewForKey(UITransitionContextToViewKey){
            let center = presentedView.center
            presentedView.center = CGPoint(x: center.x, y: -presentedView.bounds.size.height)
            
            transitionContext.containerView()?.addSubview(presentedView)
            
            UIView.animateWithDuration(self.transitionDuration(transitionContext), delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 10.0, options: [], animations: { () -> Void in
                presentedView.center = center
                }, completion: { (_ ) -> Void in
                    transitionContext.completeTransition(true )
            })
        }
    }
}
