//
//  ViewController.swift
//  Cronómetro
//
//  Created by David Santiago Fdez-Bermejo Morales on 4/3/16.
//  Copyright © 2016 David Santiago Fdez-Bermejo Morales. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var timer = NSTimer()
    var count = 0
    
    @IBOutlet weak var time: UILabel!
    
    @IBAction func pause(sender: AnyObject) {
        timer.invalidate()
    }
    
    @IBAction func stop(sender: AnyObject) {
        timer.invalidate()
        time.text = "0"
        count = 0
    }
    
    func updateTime() {
        count++
        time.text = "\(count)"
    }
    
    @IBAction func play(sender: AnyObject) {
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("updateTime"), userInfo: nil, repeats: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

