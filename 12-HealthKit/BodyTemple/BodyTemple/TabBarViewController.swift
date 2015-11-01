//
//  TabBarViewController.swift
//  BodyTemple
//
//  Created by WJ on 15/11/1.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit
import HealthKit

class TabBarViewController: UITabBarController {
    var healthStore:HKHealthStore!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        createAndPropagateHealthStore()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createAndPropagateHealthStore()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        requestAuthorisationForHealthStore()
    }
    
    private func createAndPropagateHealthStore(){
        if  healthStore == nil{
            healthStore = HKHealthStore()
        }
        for VC in viewControllers!{
            if let healthStoreUser = VC as? HealthStoreUser{
                healthStoreUser.healthStore = healthStore
            }
        }
    }

    private func requestAuthorisationForHealthStore(){
        let dataTypesToWrite  = [HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBodyMass)!]
        let dataTypesToRead = [HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBodyMass)!,
                               HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeight)!,
                               HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBodyMassIndex)!,
                               HKCharacteristicType.characteristicTypeForIdentifier(HKCharacteristicTypeIdentifierDateOfBirth)!]
        
        healthStore.requestAuthorizationToShareTypes(Set(dataTypesToWrite), readTypes: Set(dataTypesToRead)) { (success, error ) -> Void in
            if success{
                print("User completed authorisation request.")
            }else{
                print("The user cancelled the authorisation request. \(error)")
            }
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
