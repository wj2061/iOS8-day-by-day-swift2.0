//
//  ViewController.swift
//  MapOff
//
//  Created by WJ on 15/11/27.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController ,MKMapViewDelegate{
    @IBOutlet weak var mapView: MKMapView!
    
    let activityType = "wj.MapOff.viewport"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if userActivity?.activityType != activityType{
            userActivity?.invalidate()
            userActivity = NSUserActivity(activityType: activityType)
        }
        userActivity?.needsSave = true
        mapView.delegate = self
    }
    
    // MARK:- UIResponder Activity Handling
    override func updateUserActivityState(activity: NSUserActivity) {
        let regionData = withUnsafePointer(&mapView.region) {
            NSData(bytes: $0, length: sizeof(MKCoordinateRegion))
        }
        activity.userInfo = ["region" : regionData]
    }
    
    override func restoreUserActivityState(activity: NSUserActivity) {
        if activity.activityType == activityType{
            let regionData = activity.userInfo!["region"] as! NSData
            var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 0, longitudeDelta: 0))
            regionData.getBytes(&region, length: sizeof(MKCoordinateRegion))
            mapView.setRegion(region, animated: true)
        }
    }
    
    // MARK:- MKMapViewDelegate
    func mapView(mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        userActivity?.needsSave = true
    }
    
    





}

