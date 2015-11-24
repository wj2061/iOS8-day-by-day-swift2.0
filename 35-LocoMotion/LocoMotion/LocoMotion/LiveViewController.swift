//
//  LiveViewController.swift
//  LocoMotion
//
//  Created by WJ on 15/11/24.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit
import CoreMotion
import CoreLocation


class LiveViewController: UIViewController {
    
    @IBOutlet weak var activityImageView: UIImageView!
    @IBOutlet weak var stepsLabel: UILabel!
    @IBOutlet weak var floorsLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var altitudeLabel: UILabel!
    
    let dataProcessingQueue = NSOperationQueue()
    let pedometer = CMPedometer()
    let altimeter = CMAltimeter()
    let activityManager = CMMotionActivityManager()
    
    
    
    let lengthFormatter = NSLengthFormatter()
    
    var altChange:Double = 0
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        if CMSensorRecorder.isAuthorizedForRecording(){
            print("senser")
        }else{
            print("not senser")
        }
        
        lengthFormatter.numberFormatter.usesSignificantDigits = false
        lengthFormatter.numberFormatter.maximumSignificantDigits = 2
        lengthFormatter.unitStyle = .Short
    
        altimeter.startRelativeAltitudeUpdatesToQueue(dataProcessingQueue) { (data , error ) -> Void in
            if let error  = error {
                print("There was an error obtaining altimeter data: \(error)")
                return
            }
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.altChange += data!.relativeAltitude.doubleValue
                self.altitudeLabel.text = "\(self.lengthFormatter.stringFromMeters(self.altChange))"
            })
        }
        
        
        pedometer.startPedometerUpdatesFromDate(NSDate()) { (data , error ) -> Void in
            if let error  = error {
                print("There was an error obtaining pedometer data: \(error)")
                return
            }
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.floorsLabel.text = "\(data!.floorsAscended!)"
                self.stepsLabel.text  = "\(data!.numberOfSteps)"
                self.distanceLabel.text = "\(self.lengthFormatter.stringFromMeters(data!.distance!.doubleValue))"
                print("kk")
            })
        }
        
        activityManager.startActivityUpdatesToQueue(dataProcessingQueue) { (data ) -> Void in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                if data!.running{
                    self.activityImageView.image = UIImage(named: "run")
                }else if data!.cycling{
                    self.activityImageView.image = UIImage(named: "cycle")
                }else if data!.walking{
                    self.activityImageView.image = UIImage(named: "walk")
                }else{
                    self.activityImageView.image = nil
                }
            })
        }

    }



    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
