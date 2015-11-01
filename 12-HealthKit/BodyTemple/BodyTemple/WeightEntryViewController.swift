//
//  WeightEntryViewController.swift
//  BodyTemple
//
//  Created by WJ on 15/11/1.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit
import HealthKit


protocol WeightEntryDelegate{
    func weightEntryDidComplete(weight: HKQuantitySample)
}



class WeightEntryViewController: UIViewController {
    var weightEntryDelegate:WeightEntryDelegate?

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var weightEntryTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.maximumDate = NSDate()
        
        let gr = UITapGestureRecognizer(target: self, action: Selector("tap:"))
        view.addGestureRecognizer(gr)
    }
    
    @IBAction func handleSaveButtonTapped(sender: UIButton) {
        if let massNumber = numberString(weightEntryTextField.text!){
            let weightType = HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierBodyMass)
            let weightValue = HKQuantity(unit: HKUnit(fromString: "kg"), doubleValue: massNumber)
            let metadata = [HKMetadataKeyWasUserEntered:true]
            let sample = HKQuantitySample(type: weightType!, quantity: weightValue, startDate: datePicker.date, endDate: datePicker.date, metadata: metadata)
            
            weightEntryDelegate?.weightEntryDidComplete(sample)
        }
        navigationController?.popViewControllerAnimated(true)
    }

    func tap(gesture:UITapGestureRecognizer){
        weightEntryTextField.resignFirstResponder()
    }
    
 
    
    //MARK: Utility functions
    func numberString(input: String) -> Double? {
        let formatter = NSNumberFormatter()
        var result:Double? = nil
        let parsed = formatter.numberFromString(input)
        if let parsed = parsed{
            result = parsed.doubleValue
        }
        return result
    }

}
