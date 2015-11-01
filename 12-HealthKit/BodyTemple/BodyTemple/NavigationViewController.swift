//
//  NavigationViewController.swift
//  BodyTemple
//
//  Created by WJ on 15/11/1.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit
import HealthKit

class NavigationViewController: UINavigationController,HealthStoreUser {
    var  healthStore: HKHealthStore?{
        get {
            if let heathStoreUser = topViewController as? HealthStoreUser{
                return heathStoreUser.healthStore
            }else{
                return nil
            }
        }
        set{
            if let heathStoreUser = topViewController as? HealthStoreUser{
                heathStoreUser.healthStore = newValue
            }
        }
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
