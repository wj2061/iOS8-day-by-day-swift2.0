//
//  HistoricalViewController.swift
//  LocoMotion
//
//  Created by WJ on 15/11/24.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit
import CoreMotion

class HistoricalViewController: UITableViewController {
    let motionActivityManager = CMMotionActivityManager()
    let motionHandlerQueue = NSOperationQueue()
    let dateFormatter = NSDateFormatter()
    let lengthFormatter = NSLengthFormatter()
    let pedometer = CMPedometer()
    
    var activityCollection:ActivityCollection?{
        didSet{
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 76
        fetchMotionActivityData()
        dateFormatter.dateStyle = .NoStyle
        dateFormatter.timeStyle = .ShortStyle
    }

    func  fetchMotionActivityData(){
        if CMMotionActivityManager.isActivityAvailable(){
            let oneWeekInterval = 24*3600 as NSTimeInterval
            motionActivityManager.queryActivityStartingFromDate(NSDate(timeIntervalSinceNow: -oneWeekInterval), toDate: NSDate(), toQueue: motionHandlerQueue, withHandler: { (activities, error) -> Void in
                if let error = error {
                    print("There was an error retrieving the motion results: \(error)")
                    return
                }
                if activities != nil{
                    self.activityCollection = ActivityCollection(activities: activities!)
                }
            })
        }
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activityCollection?.activitise.count ?? 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! MotionActivityCell
        cell.dateFormatter = dateFormatter
        cell.lengthFormatter = lengthFormatter
        cell.pedometer = pedometer
        cell.activity = activityCollection?.activitise[indexPath.row]
        return cell
    }
}
