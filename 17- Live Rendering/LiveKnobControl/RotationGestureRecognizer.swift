//
//  RotationGestureRecognizer.swift
//  LiveKnobControl
//
//  Created by WJ on 15/11/6.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit

class RotationGestureRecognizer: UIPanGestureRecognizer {
    var touchAngle :CGFloat = 0.0
    
    override init(target: AnyObject?, action: Selector) {
        super.init(target: target, action: action)
        self.minimumNumberOfTouches = 1
        self.maximumNumberOfTouches = 1
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent) {
        super.touchesBegan(touches, withEvent: event)
        updateTouchAngleWithTouches(touches)
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent) {
        super.touchesMoved(touches, withEvent: event)
        updateTouchAngleWithTouches(touches)
    }
    
    func updateTouchAngleWithTouches(touches:NSSet){
        if let touch = touches.anyObject() as? UITouch{
            let touchpoint = touch.locationInView(view)
            touchAngle = calculateAngleToPoint(touchpoint)
        }
    }
    
    func calculateAngleToPoint(point:CGPoint)->CGFloat{
        let centerOffSet = CGPoint(x: point.x - CGRectGetMidX(view!.bounds), y: point.y - CGRectGetMidY(view!.bounds))
        return atan2(centerOffSet.x, centerOffSet.y)
    }
    
    

}
