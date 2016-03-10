//
//  ViewController.swift
//  Que tiempo hace
//
//  Created by David Santiago Fdez-Bermejo Morales on 9/3/16.
//  Copyright © 2016 David Santiago Fdez-Bermejo Morales. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var userCity: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    
    
    @IBAction func findWeather(sender: AnyObject) {
        
        let url = NSURL(string: "http://www.weather-forecast.com/locations/\(userCity.text!.stringByReplacingOccurrencesOfString(" ", withString: "-"))/forecasts/latest")
        print(url)
        var weather = ""
        
        if url != nil {
            
            let task = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: { (data, response, error) -> Void in
                var urlError = false
                
                let urlContent = NSString(data: data!, encoding: NSUTF8StringEncoding) as NSString!
                
                let urlContentArray = urlContent.componentsSeparatedByString("<span class=\"phrase\">")
                
                if urlContentArray.count > 1 {
                    let weatherArray = urlContentArray[1].componentsSeparatedByString("</span>")
                    weather = weatherArray[0]
                    
                    weather = weather.stringByReplacingOccurrencesOfString("&deg;", withString: "º")
                    
                    print(weather)
                } else {
                    urlError = true
                }
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    
                    if urlError {
                        self.showError()
                    } else {
                        self.resultLabel.text = weather
                    }
                    
                })
                
                
                
                
                
            })
            
            task.resume()
            
        } else {
            showError()
        }

        
    }
    
    func showError() {
        resultLabel.text = "No se pudo encontrar el tiempo en \(userCity.text!). Por favor, inténtelo de nuevo"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

