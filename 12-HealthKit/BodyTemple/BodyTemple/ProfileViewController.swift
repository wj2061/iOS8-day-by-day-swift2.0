//
//  ProfileViewController.swift
//  BodyTemple
//
//  Created by WJ on 15/11/1.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit
import HealthKit

class ProfileViewController: UIViewController ,HealthStoreUser{
    var healthStore:HKHealthStore?

    @IBOutlet weak var ageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestAgeAndUpdate()
    }
    
    
    func requestAgeAndUpdate(){
        let dob:NSDate?
        do {
            dob = try healthStore?.dateOfBirth()
        }catch let error {
            print("There was an error requesting the date of birth: \(error)")
            return
        }
        let now = NSDate()
        
        let age = NSCalendar.currentCalendar().components(.Year, fromDate: dob!, toDate: now, options: .WrapComponents)
        
        self.ageLabel.text = "\(age.year)"
    }
}
