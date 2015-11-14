//
//  ConfigureTimerViewController.swift
//  NotifyTimely
//
//  Created by wj on 15/11/14.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit

protocol TimerConfigurationDelegate{
    func configurationDidCancel()
    func configurationDidSetDuration(duration: Float)
}

class ConfigureTimerViewController: UIViewController {
    
    var timerConfigDelegate: TimerConfigurationDelegate?

    @IBOutlet weak var durationTextField: UITextField!
    
    
    @IBAction func handleSaveButtonPressed(sender: UIButton) {
        if let string = durationTextField.text{
            timerConfigDelegate?.configurationDidSetDuration((string as NSString).floatValue)
        }
    }

    @IBAction func handleCancelButtonPressed(sender: UIButton) {
        timerConfigDelegate?.configurationDidCancel()
    }
}
