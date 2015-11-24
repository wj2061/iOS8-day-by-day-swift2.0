//
//  ActivityCollection.swift
//  LocoMotion
//
//  Created by WJ on 15/11/24.
//  Copyright © 2015年 wj. All rights reserved.
//

import Foundation
import CoreMotion

enum ActivityType{
    case Cycling
    case Running
    case Walking
    case Other
}

struct Activity{
    let type :ActivityType
    let startDate : NSDate
    let endDate : NSDate
    
    init(motionactivity :CMMotionActivity){
        if motionactivity.cycling{
            type = .Cycling
        }else if motionactivity.walking{
            type = .Walking
        }else if motionactivity.running{
            type = .Running
        }else{
            type = .Other
        }
        startDate = motionactivity.startDate
        endDate = motionactivity.startDate
    }
    
    init(activity:Activity,newEndDate:NSDate){
        type = activity.type
        startDate = activity.startDate
        endDate = newEndDate
    }
    
    func appendActivity(activity:Activity)->Activity{
        return Activity(activity: self, newEndDate: activity.endDate)
    }
}

class ActivityCollection{
    var activitise = [Activity]()
    
    init(activities: [CMMotionActivity]) {
        addMotionActivities(activities)
    }
    
    func addMotionActivity(motionActivity:CMMotionActivity){
        var activity = Activity(motionactivity: motionActivity)
        if activity.type == activitise.last?.type{
            activity = activitise.last!.appendActivity(activity)
            activitise.removeLast()
        }
        if activity.type != .Other{
            activitise.append(activity)
        }
    }
    
    func addMotionActivities(motionActivities:[CMMotionActivity]){
        for activity in motionActivities{
            addMotionActivity(activity)
        }
    }
    
    
}

