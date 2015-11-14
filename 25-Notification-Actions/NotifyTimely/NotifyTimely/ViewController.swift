//
//  ViewController.swift
//  NotifyTimely
//
//  Created by wj on 15/11/14.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,TimerConfigurationDelegate, TimerNotificationManagerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTimerUI()
    }
    
    var timerNotificationManager: TimerNotificationManager? {
        didSet {
            timerNotificationManager?.delegate = self
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "configureTimer" {
            if let configVC = segue.destinationViewController as? ConfigureTimerViewController {
                configVC.timerConfigDelegate = self
            }
        }
    }

    @IBOutlet weak var timerStatusLabel: PaddedLabel!
    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var editButton: UIButton!

    @IBAction func handleTimerButtonPress(sender: UIButton) {
        switch sender {
        case restartButton:
            timerNotificationManager?.restartTimer()
        case startButton:
            timerNotificationManager?.startTimer()
        case stopButton:
            timerNotificationManager?.stopTimer()
        default:
            print("Unknown Sender")
        }
    }
    
    
    private func configureTimerUI() {
        if let timerRunning = timerNotificationManager?.timerRunning{
            setButton(restartButton, enabled: timerRunning)
            setButton(startButton, enabled: !timerRunning)
            setButton(stopButton, enabled: timerRunning)
            setButton(editButton, enabled: !timerRunning)
            
            timerStatusLabel.text =  "\(timerNotificationManager!)"
        }
    }

    private func setButton(button: UIButton, enabled: Bool) {
        button.enabled = enabled
        button.alpha = enabled ? 1.0 : 0.3
    }
    
    // MARK: - TimerConfigurationDelegate Methods
    func configurationDidCancel() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func configurationDidSetDuration(duration: Float) {
        timerNotificationManager?.timerDuration = duration
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - TimerNotificationManagerDelegate methods
    func timerStatusChanged() {
        configureTimerUI()
    }
    
    func presentEditOptions() {
        performSegueWithIdentifier("configureTimer", sender: self)
    }

}

