//
//  WeightTableViewController.swift
//  BodyTemple
//
//  Created by WJ on 15/11/1.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit
import HealthKit

class WeightTableViewController: UITableViewController ,HealthStoreUser,WeightEntryDelegate{
     var healthStore:HKHealthStore?
    
    let dateFormatter = NSDateFormatter()
    let massFormatter = NSMassFormatter()
    
    var weightSamples = [HKQuantitySample]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        perfromQueryForWeightSamples()
        massFormatter.forPersonMassUse = true
        dateFormatter.dateStyle = .MediumStyle
        dateFormatter.timeStyle = .NoStyle
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weightSamples.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let sample = weightSamples[indexPath.row]
        let weight = sample.quantity.doubleValueForUnit(HKUnit(fromString: "kg"))
        
        cell.detailTextLabel?.text = "\(massFormatter.stringFromValue(weight, unit: .Kilogram))"
        cell.textLabel?.text = "\(dateFormatter.stringFromDate(sample.startDate))"

        return cell
    }
    
    // MARK: - WeightEntryDelegate
    func weightEntryDidComplete(weight: HKQuantitySample){
        saveSampleToHealthStore(weight)
        weightSamples.insert(weight, atIndex: 0)
        tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: 0, inSection: 0)], withRowAnimation: .Automatic)
    }

    // MARK: - HealthStore utility methods
    func perfromQueryForWeightSamples() {
        let endDate = NSDate()
        let startDate = NSCalendar.currentCalendar().dateByAddingUnit(.Month, value: -2, toDate: endDate, options: [])
        
        let weightSampleType = HKSampleType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBodyMass)
        let predicate = HKQuery.predicateForSamplesWithStartDate(startDate, endDate: endDate, options: .None)
        
        let query = HKSampleQuery(sampleType: weightSampleType!, predicate: predicate, limit: 0, sortDescriptors: nil) { (query, results, error ) -> Void in
            if results == nil{
                print("There was an error running the query: \(error)")
            }
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.weightSamples = results as!  [HKQuantitySample]
                self.tableView.reloadData()
            })
        }
        healthStore?.executeQuery(query)
    }

    func saveSampleToHealthStore(sample: HKObject) {
       print("save weight")
       healthStore?.saveObject(sample, withCompletion: { (success, error ) -> Void in
        if success{
            print("Weight saved successfully 😃")
        }else{
            print("Error: \(error)")
        }
       })
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "addWeightSample"{
            let VC = segue.destinationViewController as! WeightEntryViewController
            VC.weightEntryDelegate = self
        }

    }

}
