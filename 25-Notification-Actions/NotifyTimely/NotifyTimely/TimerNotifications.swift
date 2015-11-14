//
//  TimerNotifications.swift
//  NotifyTimely
//
//  Created by wj on 15/11/14.
//  Copyright © 2015年 wj. All rights reserved.
//

import Foundation
import UIKit

let restartTimerActionString = "RestartTimer"
let editTimerActionString = "EditTimer"
let snoozeTimerActionString = "SnoozeTimer"
let timerFiredCategoryString = "TimerFiredCategory"

protocol TimerNotificationManagerDelegate {
    func timerStatusChanged()
    func presentEditOptions()
}

class TimerNotificationManager:CustomStringConvertible{
    let snoozeDuration:Float  = 5.0
    var delegate: TimerNotificationManagerDelegate?
    
    var timerRunning:Bool{
        didSet{
            delegate?.timerStatusChanged()
        }
    }
    
    var timerDuration:Float{
        didSet{
            delegate?.timerStatusChanged()
        }
    }
    
    var description:String{
        if timerRunning{
            return "\(timerDuration)s timer, running"
        }else{
            return "\(timerDuration)s timer, stopped"
        }
    }
    
    init(){
        timerRunning = false
        timerDuration = 30.0
        registerForNotifications()
        checkForPreExistingTimer()
    }
    
    func startTimer() {
        if !timerRunning{
            scheduleTimerWithOffset(timerDuration)
        }
    }
    
    func stopTimer(){
        if timerRunning{
            UIApplication.sharedApplication().cancelAllLocalNotifications()
            timerRunning = false
        }
    }
    
    func restartTimer() {
        stopTimer()
        startTimer()
    }
    
    func timerFired() {
        timerRunning = false
    }
    
    func handleActionWithIdentifier(identifier: String?) {
        timerRunning  = false
        if let identifier = identifier{
            switch identifier{
            case restartTimerActionString:
                restartTimer()
            case snoozeTimerActionString:
                scheduleTimerWithOffset(snoozeDuration)
            case editTimerActionString:
                delegate?.presentEditOptions()
            default:
                print("Unrecognised Identifier")
            }
        }
    }
    
    
    
    // MARK: - Utility methods
    
    

    private func scheduleTimerWithOffset(fireOffset: Float) {
        let timer = createTimer(fireOffset)
        UIApplication.sharedApplication().scheduleLocalNotification(timer)
        timerRunning = true
    }
    
    private func createTimer(fireOffset: Float) -> UILocalNotification {
        let notification = UILocalNotification()
        notification.category = timerFiredCategoryString
        notification.fireDate = NSDate(timeIntervalSinceNow: NSTimeInterval(fireOffset) )
        notification.alertBody = "Your time is up!"
        return notification
    }
    
    
    
    private func registerForNotifications(){
        let requestedTypes:UIUserNotificationType = [UIUserNotificationType.Alert,.Sound]
        let categories:Set =  [timerFiredNotificationCategory()]
        let settingRequest = UIUserNotificationSettings(forTypes: requestedTypes, categories: categories)
        UIApplication.sharedApplication().registerUserNotificationSettings(settingRequest)
    }
    
    private func timerFiredNotificationCategory() -> UIUserNotificationCategory {
        let restartAction = UIMutableUserNotificationAction()
        restartAction.identifier = restartTimerActionString
        restartAction.destructive = false
        restartAction.title = "Restart"
        restartAction.activationMode = .Background
        restartAction.authenticationRequired = false
        
        let editAction = UIMutableUserNotificationAction()
        editAction.identifier = editTimerActionString
        editAction.destructive = false
        editAction.title = "Edit"
        editAction.activationMode = .Foreground
        editAction.authenticationRequired = true
        
        let snoozeAction = UIMutableUserNotificationAction()
        snoozeAction.identifier = snoozeTimerActionString
        snoozeAction.destructive = false
        snoozeAction.title = "snooze"
        snoozeAction.activationMode = .Background
        snoozeAction.authenticationRequired = false
        
        let category = UIMutableUserNotificationCategory()
        category.identifier = timerFiredCategoryString
        category.setActions([restartAction,snoozeAction], forContext: .Minimal)
        category.setActions([restartAction,snoozeAction,editAction], forContext: .Default)
        
        return category
    }
    
    private func checkForPreExistingTimer() {
        if UIApplication.sharedApplication().scheduledLocalNotifications!.count > 0{
            timerRunning = true
        }
    }
    
    
    
}