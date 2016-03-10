//
//  ViewController.swift
//  Almacenamiento Persistente
//
//  Created by David Santiago Fdez-Bermejo Morales on 7/3/16.
//  Copyright © 2016 David Santiago Fdez-Bermejo Morales. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //NSUserDefaults.standardUserDefaults().setObject("David", forKey: "name")
        
        let name = NSUserDefaults.standardUserDefaults().objectForKey("name") as! String
        
        print(name)
        
        let arr = [1, 2, 3]
        
        //NSUserDefaults.standardUserDefaults().setObject(arr, forKey: "array")
        
        let recalledArray = NSUserDefaults.standardUserDefaults().objectForKey("array") as! NSArray
        print(recalledArray)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

