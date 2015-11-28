//
//  InterfaceController.swift
//  WatchApp Extension
//
//  Created by wj on 15/11/28.
//  Copyright © 2015年 wj. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    
    var quotes = [Quote]()
    var currentQuote: Int = 0
    let quoteGenerator = NightWatchQuotes()
    var timer: NSTimer?
    let quoteCycleTime: NSTimeInterval = 30
    
    @IBOutlet weak var quoteLabel: WKInterfaceLabel!
    @IBOutlet weak var quoteChangeTimer: WKInterfaceTimer!

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        if quotes.count != 5 {
            quotes = quoteGenerator.randomQuotes(5)
        }
        quoteLabel.setText(quotes[currentQuote])
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        timer?.invalidate()
        timer = NSTimer.scheduledTimerWithTimeInterval(quoteCycleTime, target: self, selector: "fireTimer:", userInfo: nil , repeats: true)
        quoteChangeTimer.setDate(NSDate(timeIntervalSinceNow: quoteCycleTime))
        quoteChangeTimer.start()
    }
    
    @IBAction func handleSkipButtonPressed() {
        timer?.fire()
        timer?.invalidate()
        timer = NSTimer.scheduledTimerWithTimeInterval(quoteCycleTime, target: self, selector: "fireTimer:", userInfo: nil, repeats: true)
    }

    override func didDeactivate() {
        timer?.invalidate()
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func fireTimer(timer:NSTimer){
        currentQuote = (currentQuote + 1) % quotes.count
        quoteLabel.setText(quotes[currentQuote])
        quoteChangeTimer.setDate(NSDate(timeIntervalSinceNow: quoteCycleTime))
        quoteChangeTimer.start()
    }

}
