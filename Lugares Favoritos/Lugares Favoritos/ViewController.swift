//
//  ViewController.swift
//  Lugares Favoritos
//
//  Created by David Santiago Fdez-Bermejo Morales on 11/3/16.
//  Copyright © 2016 David Santiago Fdez-Bermejo Morales. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var map: MKMapView!
    
    let manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if activePlace == -1 {
            manager.desiredAccuracy = kCLLocationAccuracyBest
            manager.delegate = self
            manager.requestWhenInUseAuthorization()
            manager.startUpdatingLocation()
        } else {
            let latitude = NSString(string: places[activePlace]["lat"]!).doubleValue
            let longitude = NSString(string: places[activePlace]["lon"]!).doubleValue
            
            self.centerMap(latitude, longitude: longitude)
            self.addPoint(latitude, longitude: longitude, title: places[activePlace]["name"]!)
        }
        
        
        
        let lpgr = UILongPressGestureRecognizer(target: self, action: "longPressDetected:")
        lpgr.minimumPressDuration = 2
        
        self.map.addGestureRecognizer(lpgr)
    }
    
    func centerMap(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let latDelta = 0.01
        let lonDelta = 0.01
        let span = MKCoordinateSpanMake(latDelta, lonDelta)
        let coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        let region = MKCoordinateRegionMake(coordinate, span)
        self.map.setRegion(region, animated: true)
    }
    
    func addPoint(latitude: CLLocationDegrees, longitude: CLLocationDegrees, title: String) {
        let coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = title
        self.map.addAnnotation(annotation)
    }
    
    func longPressDetected(gestureRecognizer: UIGestureRecognizer) {
        if gestureRecognizer.state == UIGestureRecognizerState.Recognized {
            let touchPoint = gestureRecognizer.locationInView(self.map)
            let newCoordinate = self.map.convertPoint(touchPoint, toCoordinateFromView: self.map)
            
            let location = CLLocation(latitude: newCoordinate.latitude, longitude: newCoordinate.longitude)
            CLGeocoder().reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
                var title = ""
                
                if let p = placemarks?.first {
                    if p.thoroughfare != nil {
                        title += "\(p.thoroughfare!)"
                    }
                    if p.subThoroughfare != nil {
                        title += " \(p.subThoroughfare!)"
                    }
                }
                
                if title == "" {
                    title = "Desconocido"
                }
                
                self.addPoint(newCoordinate.latitude, longitude: newCoordinate.longitude, title: title)
                
                places.append(["name": title, "lat": "\(newCoordinate.latitude)", "lon": "\(newCoordinate.longitude)"])
                
            })
            
            
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let userLocation = locations.first {
            let latitude = userLocation.coordinate.latitude
            let longitude = userLocation.coordinate.longitude
            self.centerMap(latitude, longitude: longitude)
        }
    }


}

