//
//  HorseRaceController.swift
//  HorseRace
//
//  Created by WJ on 15/10/31.
//  Copyright © 2015年 wj. All rights reserved.
//

import Foundation
import UIKit

public struct Horse {
     public let horseView: UIView
     let startFrame: CGRect
     let finishFrame: CGRect
    
    init(horseView: UIView, startFrame: CGRect, finishLineOffset:CGFloat) {
        self.horseView = horseView
        self.startFrame = startFrame
        self.finishFrame = CGRect(x: horseView.superview!.bounds.size.width-startFrame.width-finishLineOffset, y: startFrame.origin.y, width: startFrame.width, height: startFrame.height)
    }
}

public class TwoHorseRaceController {
    let horses: [Horse]
    init(horses:[Horse]){
        self.horses = horses
        srand48(time(nil ))
    }
    
   public func reset(){
        for horse in horses{
            horse.horseView.frame = horse.startFrame
        }
    }
    
    public   func startRace(maxDuration: NSTimeInterval, horseCrossedLineCallback: ((Horse) -> Void)?) {
        
        for horse in horses {
            // Generate a random time
            let duration = maxDuration / 2.0 * (1 + drand48())
            
            // Perform the animation
            UIView.animateWithDuration(duration, delay: 0, options: .CurveEaseIn,
                animations: {
                    horse.horseView.frame = horse.finishFrame
                }, completion: { _ in
                    if let horseCrossedLineCallback = horseCrossedLineCallback {
                        horseCrossedLineCallback(horse)
                    }
            })
        }
    }
    
    public func someKindOfAsyncMethod(completionHandler: () -> ()) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            sleep(3)
            dispatch_async(dispatch_get_main_queue(), {
                completionHandler()})
        })
    }
    
    
}
