//
//  ViewController.swift
//  WhereAmI
//
//  Created by WJ on 15/11/23.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController,CLLocationManagerDelegate, MKMapViewDelegate  {
    @IBOutlet weak var latValLabel: UILabel!
    @IBOutlet weak var longValLabel: UILabel!
    @IBOutlet weak var altValLabel: UILabel!
    @IBOutlet weak var accValLabel: UILabel!
    @IBOutlet weak var spdValLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    let locationMananger = CLLocationManager()
    var historicalPoints = [CLLocationCoordinate2D]()
    var routeTrack = MKPolyline()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationMananger.delegate = self
        locationMananger.desiredAccuracy = 20
        locationMananger.requestWhenInUseAuthorization()
        locationMananger.startUpdatingLocation()
        
        mapView.delegate = self
    }
    
    // MARK:- CLLocationManagerDelegate methods
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first{
            latValLabel.text = "\(location.coordinate.latitude)"
            longValLabel.text = "\(location.coordinate.longitude)"
            altValLabel.text = "\(location.altitude) m"
            accValLabel.text = "\(location.horizontalAccuracy)"
            spdValLabel.text = "\(location.speed)"
            
            mapView.centerCoordinate = location.coordinate
            historicalPoints.append(location.coordinate)
            updateMapWithPoints(historicalPoints)
        }
    }
    
    // MARK:- MKMapViewDelegate methods

    
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        if let overlay = overlay as? MKPolyline{
            let renderer = MKPolylineRenderer(polyline: overlay)
            renderer.lineWidth = 4.0
            renderer.strokeColor = UIColor.blueColor().colorWithAlphaComponent(0.7)
            return renderer
        }
        return MKPolylineRenderer()
    }

    // MARK:- Utility Methods
    private func updateMapWithPoints(points: [CLLocationCoordinate2D]) {
        let oldTrack = routeTrack
        
        var coordinates = points
        
        routeTrack = MKPolyline(coordinates: &coordinates, count: points.count)
        
        mapView.addOverlay(routeTrack)
        mapView.removeOverlay(oldTrack)
        
        mapView.visibleMapRect = mapView.mapRectThatFits(routeTrack.boundingMapRect, edgePadding: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))   
    }

}

