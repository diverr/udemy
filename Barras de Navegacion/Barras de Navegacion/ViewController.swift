//
//  ViewController.swift
//  Barras de Navegacion
//
//  Created by David Santiago Fdez-Bermejo Morales on 3/3/16.
//  Copyright © 2016 David Santiago Fdez-Bermejo Morales. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var timer = NSTimer()
    
    var count = 0
    
    func result() {
        print("Método llamado \(count)")
        count++
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("result"), userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

