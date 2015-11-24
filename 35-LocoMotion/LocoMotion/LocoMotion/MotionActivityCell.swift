//
//  MotionActivityCell.swift
//  LocoMotion
//
//  Created by WJ on 15/11/24.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit
import CoreMotion

class MotionActivityCell: UITableViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pedometerLabel: UILabel!
    
    var activity:Activity?{
        didSet{
            prepareCellForActivity(activity)
        }
    }
    
    var dateFormatter: NSDateFormatter?
    var lengthFormatter: NSLengthFormatter?
    var pedometer: CMPedometer?
    
    // MARK:- Utility methods
    private func prepareCellForActivity(activity: Activity?){
        if let activity = activity{
            var imageName = ""
            switch activity.type{
            case .Cycling:
                imageName = "cycle"
                pedometerLabel.text = ""
            case .Running:
                imageName = "run"
                requestPedometerData()
            case .Walking:
                imageName = "walk"
                requestPedometerData()
            default:
                imageName = ""
                pedometerLabel.text = ""
            }
            iconImageView.image = UIImage(named: imageName)
            titleLabel.text = "(\(dateFormatter!.stringFromDate(activity.startDate))-\(dateFormatter!.stringFromDate(activity.endDate)))"
        }
    }
    
      private func requestPedometerData() {
        pedometer?.queryPedometerDataFromDate(activity!.startDate, toDate: activity!.endDate, withHandler: { (data , error ) -> Void in
            if let error = error{
                print("There was an error requesting data from the pedometer: \(error)")
                return
            }
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.pedometerLabel.text = self.constructPedometerString(data!)
            })
        })
    }
    
    private func constructPedometerString(data: CMPedometerData) -> String {
        var pedometerString = ""
        if CMPedometer.isStepCountingAvailable(){
            pedometerString += "\(data.numberOfSteps) steps | "
        }
        if CMPedometer.isDistanceAvailable(){
            pedometerString += "\(lengthFormatter!.stringFromMeters(data.distance!.doubleValue)) | "
        }
        if CMPedometer.isFloorCountingAvailable(){
            pedometerString += "\(data.floorsAscended!) floors"
        }
        return pedometerString
    }
}
