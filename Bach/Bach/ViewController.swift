//
//  ViewController.swift
//  Bach
//
//  Created by David Santiago Fdez-Bermejo Morales on 14/3/16.
//  Copyright © 2016 David Santiago Fdez-Bermejo Morales. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player = AVAudioPlayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let audioPath = NSBundle.mainBundle().pathForResource("bach1", ofType: "mp3") {
            do {
                self.player = try AVAudioPlayer(contentsOfURL: NSURL(string: audioPath)!)
            } catch let error as NSError {
                print (error)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func play(sender: AnyObject) {
        self.player.play()
    }

    @IBAction func pause(sender: AnyObject) {
        self.player.pause()
    }
    
    @IBAction func stop(sender: AnyObject) {
        self.player.stop()
        self.player.currentTime = 0
    }
    
    @IBAction func sliderChange(sender: AnyObject) {
        self.player.volume = sender.value
    }
    
}

