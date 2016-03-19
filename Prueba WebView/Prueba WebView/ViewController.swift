//
//  ViewController.swift
//  Prueba WebView
//
//  Created by David Santiago Fdez-Bermejo Morales on 18/3/16.
//  Copyright © 2016 David Santiago Fdez-Bermejo Morales. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //let url = NSURL(string: "https://www.google.es")
        //let urlRequest = NSURLRequest(URL: url!)
        
        //self.webView.loadRequest(urlRequest)
        
        let html = "<html><head></head><body><h1>Holaaa!</h1></body></html>"
        self.webView.loadHTMLString(html, baseURL: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

