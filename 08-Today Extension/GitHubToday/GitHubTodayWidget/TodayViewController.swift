//
//  TodayViewController.swift
//  GitHubTodayWidget
//
//  Created by WJ on 15/10/29.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit
import NotificationCenter
import GitHubTodayCommon


class TodayViewController: UIViewController, NCWidgetProviding {
        
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var RepoNameLabel: UILabel!
    
    let dataProvider = GitHubDataProvider()
    let mostRecentEventCache = GitHubEventCache(userDefaults: NSUserDefaults(suiteName: "group.com.cn")!)
    var currentEvent:GitHubEvent?{
        didSet{
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                if let event = self.currentEvent{
                    self.typeLabel.text = event.eventType.icon
                    self.RepoNameLabel.text = event.repoName
                }else{
                    self.typeLabel.text = ""
                    self.RepoNameLabel.text = ""
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentEvent = mostRecentEventCache.mostRecentEvent
    }
    
    func widgetMarginInsetsForProposedMarginInsets(defaultMarginInsets: UIEdgeInsets) -> UIEdgeInsets {
        let newInsets = UIEdgeInsets(top: defaultMarginInsets.top, left: defaultMarginInsets.left-30, bottom: defaultMarginInsets.bottom, right: defaultMarginInsets.right)
        return newInsets
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.

        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        dataProvider.getEvents("sammyd") { (events) -> () in
            if let newEvent = events.first{
                if newEvent != self.currentEvent{
                    self.currentEvent = newEvent
                    self.mostRecentEventCache.mostRecentEvent = newEvent
                    print("newdata")
                    completionHandler(NCUpdateResult.NewData)
                }else{
                    print("nodata")
                    completionHandler(NCUpdateResult.NoData)
                }
            }
        }
        completionHandler(NCUpdateResult.NewData)
    }
    
    @IBAction func handlemoreButtonPressed(sender: AnyObject) {
        let url = NSURL(scheme: "githubtoday", host: nil, path: "\(currentEvent?.id)")
        extensionContext?.openURL(url!, completionHandler: nil)
    }
}
