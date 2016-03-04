//
//  ViewController.swift
//  EdadGatuna
//
//  Created by David Santiago Fdez-Bermejo Morales on 1/3/16.
//  Copyright © 2016 David Santiago Fdez-Bermejo Morales. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var age: UITextField!
    
    @IBOutlet weak var result: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func findAge(sender: AnyObject) {
        let humanAge = Int(age.text!)
        if(humanAge != nil) {
            let catAge = humanAge! * 7
            result.text = "Tu gato tiene \(catAge) años gatunos"
        } else {
            result.text = "Por favor introduce una edad"
        }
    }

}

