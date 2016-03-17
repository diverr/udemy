//
//  ViewController.swift
//  Almacenamiento Imagenes
//
//  Created by David Santiago Fdez-Bermejo Morales on 17/3/16.
//  Copyright © 2016 David Santiago Fdez-Bermejo Morales. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var bach: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let documentsDirectory = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentationDirectory, NSSearchPathDomainMask.UserDomainMask, true).first {
            let savePath = documentsDirectory + "/bach.jpg"
            self.bach.image = UIImage(named: savePath)
            
            if self.bach.image == nil {
                print("No tenemos la imagen en disco, nos la bajamos")
                let url = NSURL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6a/Johann_Sebastian_Bach.jpg/220px-Johann_Sebastian_Bach.jpg")
                let urlRequest = NSURLRequest(URL: url!)
                let task = NSURLSession.sharedSession().dataTaskWithRequest(urlRequest) { (data, response, error) -> Void in
                    if error != nil {
                        print("Error al descargar la imagen")
                    }
                    else {
                        
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            print("La imagen ha sido descargada")
                            let image = UIImage(data: data!)
                            self.bach.image = image
                        })
                        
                        NSFileManager.defaultManager().createFileAtPath(savePath, contents: data, attributes: nil)
                        print("La imagen ha sido guardada en disco para futuras ejecuciones")
                        
                    }
                }
                
                task.resume()
                
            }
            else {
                print("Teníamos la imagen en el disco")
            }
        }
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

