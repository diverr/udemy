//
//  ViewController.swift
//  Caja de sonidos
//
//  Created by David Santiago Fdez-Bermejo Morales on 15/3/16.
//  Copyright © 2016 David Santiago Fdez-Bermejo Morales. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player = AVAudioPlayer()
    
    let sounds = ["bean", "belch", "giggle", "pew", "pig", "snore", "static", "pig"]

    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if event?.subtype == UIEventSubtype.MotionShake {
            
            let randomNumber = Int(arc4random_uniform(UInt32(sounds.count)))
            
            if let audioPath = NSBundle.mainBundle().pathForResource(self.sounds[randomNumber], offType: "mp3") {
                do {
                    self.player = try AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: audioPath))
                    self.player.play()
                } catch let error as NSError {
                    print(error)
                }
            }
        }
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

