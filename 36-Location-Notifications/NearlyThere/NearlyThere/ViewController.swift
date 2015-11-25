//
//  ViewController.swift
//  NearlyThere
//
//  Created by WJ on 15/11/25.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit
import MapKit


class ViewController: UIViewController ,CLLocationManagerDelegate,MKMapViewDelegate{
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    
    var annotation : MKPointAnnotation?
    let locationManager = CLLocationManager()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let notificationSettings = UIUserNotificationSettings(forTypes: .Alert, categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(notificationSettings)
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        mapView.delegate = self
        view.bringSubviewToFront(actionButton)
    }
    
    @IBAction func handleButtonPressed(sender: UIButton) {
        if actionButton.titleForState(.Normal) == "Drop Pin"{
            annotation = MKPointAnnotation()
            annotation?.coordinate = mapView.centerCoordinate
            mapView.addAnnotation(annotation!)
            actionButton.setTitle("Notify Me", forState: .Normal)
        }else if actionButton.titleForState(.Normal) == "Notify Me"{
            UIApplication.sharedApplication().cancelAllLocalNotifications()
            let notification = UILocalNotification()
            notification.alertBody = "You're nearly there!"
            notification.regionTriggersOnce = true
            notification.region = CLCircularRegion(center: annotation!.coordinate, radius: 80, identifier: "Destination")
            print("\(notification), \(notification.region)")
            UIApplication.sharedApplication().scheduleLocalNotification(notification)
            actionButton.setTitle("Cancel Notification", forState: .Normal)
        }else if actionButton.titleForState(.Normal) == "Cancel Notification"{
            UIApplication.sharedApplication().cancelAllLocalNotifications()
            mapView.removeAnnotation(annotation!)
            actionButton.setTitle("Drop Pin", forState: .Normal)
        }
    }
    
    // MARK:- MKMapViewDelegate methods
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "PinAnnotation")
        pin.animatesDrop = true
        return  pin
    }
    
    // MARK:- CLLocationManagerDelegate
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedWhenInUse{
            print("Ready to go!")
        }
    }



}

