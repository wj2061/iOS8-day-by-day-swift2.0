//
//  TableViewController.swift
//  GitHubToday
//
//  Created by WJ on 15/10/29.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit
import GitHubTodayCommon


class TableViewController: UITableViewController {
    let dataProvider = GitHubDataProvider()
    let mostRecentEventCache = GitHubEventCache(userDefaults: NSUserDefaults(suiteName: "group.com.cn")!)
    var events = [GitHubEvent](){
        didSet{
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                self.tableView.reloadData()
            }
        }
    }
    
    override func awakeFromNib() {
        title = "GitHub Events"
        dataProvider.getEvents("sammyd") { (githubEvents) -> () in
            self.events = githubEvents
            self.mostRecentEventCache.mostRecentEvent = githubEvents[0]
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func scrollToAndHighlightEvent(eventid:Int){
        var eventIndex:Int?
        for event in events{
            if event.id == eventid{
                eventIndex = events.indexOf(event)
            }
        }
        if let eventIndex = eventIndex{
            let indexpath = NSIndexPath(forItem: eventIndex, inSection: 0)
            tableView.selectRowAtIndexPath(indexpath, animated: true, scrollPosition: UITableViewScrollPosition.Top)
        }
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("EventCell", forIndexPath: indexPath)
        return cell
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if let  eventcell = cell as? EventTableViewCell{
            let event = events[indexPath.row]
            eventcell.event = event
        }
    }

    
}
