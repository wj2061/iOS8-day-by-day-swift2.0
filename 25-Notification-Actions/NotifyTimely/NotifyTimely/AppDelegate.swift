//
//  AppDelegate.swift
//  NotifyTimely
//
//  Created by wj on 15/11/14.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let timerNotificationManager = TimerNotificationManager()


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        if let vc = window?.rootViewController as? ViewController {
            vc.timerNotificationManager = timerNotificationManager
        }
        return true
    }
    
    func application(application: UIApplication, handleActionWithIdentifier identifier: String?, forLocalNotification notification: UILocalNotification, completionHandler: () -> Void) {
        timerNotificationManager.handleActionWithIdentifier(identifier)
        completionHandler()
    }
    
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        timerNotificationManager.timerFired()
        if application.applicationState == .Active{
            let alert = UIAlertController(title: "NotifyTimely", message: "Your time is up", preferredStyle: .Alert)
            let actionAndDismiss = {
                (action: String?) -> ((UIAlertAction!) -> ()) in
                return {
                    _ in
                    self.timerNotificationManager.handleActionWithIdentifier(action)
                    self.window?.rootViewController?.dismissViewControllerAnimated(true, completion: nil)
                }
            }
            
            alert.addAction(UIAlertAction(title: "Dismiss", style: .Cancel, handler: actionAndDismiss(nil)))
            alert.addAction(UIAlertAction(title: "Restart", style: .Default, handler: actionAndDismiss(restartTimerActionString)))
            alert.addAction(UIAlertAction(title: "Snooze", style: .Destructive, handler: actionAndDismiss(snoozeTimerActionString)))
            window?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
            
        }
    }
    

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

