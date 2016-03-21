//
//  DetailViewController.swift
//  Lector de Blogs
//
//  Created by David Santiago Fdez-Bermejo Morales on 18/3/16.
//  Copyright © 2016 David Santiago Fdez-Bermejo Morales. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!

    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            if let webView = self.webView {
                self.webView.loadHTMLString(detail.valueForKey("content")!.description, baseURL: nil)
            }
        }
        
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

