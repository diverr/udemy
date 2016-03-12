//
//  ViewController.swift
//  Audio
//
//  Created by David Santiago on 12/3/16.
//  Copyright © 2016 David Santiago. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player = AVAudioPlayer()
    
    @IBOutlet weak var slider: UISlider!
    
    @IBAction func play(sender: AnyObject) {
        if let audioPath = NSBundle.mainBundle().pathForResource("bach1", ofType: "mp3") {
            do {
                self.player = try AVAudioPlayer(contentsOfURL: NSURL(string: audioPath)!)
                self.player.play()
            } catch let error as NSError {
                print (error)
            }
        } else {
            print("no entra")
        }
    }
    
    @IBAction func pause(sender: AnyObject) {
        self.player.pause()
    }
    
    @IBAction func sliderChange(sender: AnyObject) {
        self.player.volume = self.slider.value
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

