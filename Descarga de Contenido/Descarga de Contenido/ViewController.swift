//
//  ViewController.swift
//  Descarga de Contenido
//
//  Created by David Santiago Fdez-Bermejo Morales on 9/3/16.
//  Copyright © 2016 David Santiago Fdez-Bermejo Morales. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let url = NSURL(string: "http://www.stackoverflow.com")!
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
            if error == nil && data != nil {
                let urlContent = NSString(data: data!, encoding: NSUTF8StringEncoding) as! String
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.webView.loadHTMLString(urlContent, baseURL: url)
                })
                
                print(urlContent)
            } else {
                print("Ha habido algún error")
            }
        }
        
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

