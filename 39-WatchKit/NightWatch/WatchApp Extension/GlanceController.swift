//
//  GlanceController.swift
//  WatchApp Extension
//
//  Created by wj on 15/11/28.
//  Copyright © 2015年 wj. All rights reserved.
//

import WatchKit
import Foundation


class GlanceController: WKInterfaceController {
    @IBOutlet var quoteLabel: WKInterfaceLabel!
    let quoteGenerator = NightWatchQuotes()

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        quoteLabel.setText(quoteGenerator.randomQuote())

        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        NSLog("%@ did deactivate", self)
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
