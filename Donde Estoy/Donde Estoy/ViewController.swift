//
//  ViewController.swift
//  Donde Estoy
//
//  Created by David Santiago Fdez-Bermejo Morales on 11/3/16.
//  Copyright © 2016 David Santiago Fdez-Bermejo Morales. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var latitudLabel: UILabel!
    @IBOutlet weak var longitudLabel: UILabel!
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var altitudeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    
    let manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addInfoIfExist(info: String?) -> String {
        if info != nil {
            return "\(info!)\n"
        } else {
            return ""
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let userLocation = locations.first {
            self.latitudLabel.text = "\(userLocation.coordinate.latitude)"
            self.longitudLabel.text = "\(userLocation.coordinate.longitude)"
            self.courseLabel.text = "\(userLocation.course)"
            self.speedLabel.text = "\(userLocation.speed)"
            self.altitudeLabel.text = "\(userLocation.altitude)"
            
            CLGeocoder().reverseGeocodeLocation(userLocation, completionHandler: { (placemarks, error) -> Void in
                if error != nil {
                    print(error)
                } else {
                    if let p = placemarks?[0] {
                        
                        var address = ""
                        address += self.addInfoIfExist(p.thoroughfare)
                        address += self.addInfoIfExist(p.subThoroughfare)
                        address += self.addInfoIfExist(p.subAdministrativeArea)
                        address += self.addInfoIfExist(p.administrativeArea)
                        address += self.addInfoIfExist(p.postalCode)
                        address += self.addInfoIfExist(p.country)
                        
                        self.addressLabel.text = address
                    }
                }
            })
        }
    }


}

