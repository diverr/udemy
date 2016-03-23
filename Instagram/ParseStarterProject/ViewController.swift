/**
* Copyright (c) 2015-present, Parse, LLC.
* All rights reserved.
*
* This source code is licensed under the BSD-style license found in the
* LICENSE file in the root directory of this source tree. An additional grant
* of patent rights can be found in the PATENTS file in the same directory.
*/

import UIKit
import Parse

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var pickedImage: UIImageView!
    
    let loading = UIActivityIndicatorView()
    
    @IBAction func pause(sender: AnyObject) {
        
        self.loading.center = self.view.center
        self.loading.hidesWhenStopped = true
        self.loading.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        self.loading.startAnimating()
        
        self.view.addSubview(self.loading)
        
        // para que no se puedan pulsar otros botones
        //UIApplication.sharedApplication().beginIgnoringInteractionEvents()
    }
    
    @IBAction func restart(sender: AnyObject) {
        self.loading.stopAnimating()
        //UIApplication.sharedApplication().endIgnoringInteractionEvents()
    }
    
    @available(iOS 8.0, *)
    @IBAction func createAlert(sender: AnyObject) {
        let alert = UIAlertController(title: "Un momento", message: "¿Estás seguro de continuar?", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "Aceptar", style: .Default, handler: { (action) in
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
            
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func pickImage(sender: AnyObject) {
        let imagePC = UIImagePickerController()
        imagePC.delegate = self
        
        imagePC.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        // si queremos una foto de la cámara símplemente cambiamos este source
        //imagePC.sourceType = UIImagePickerControllerSourceType.Camera
        
        imagePC.allowsEditing = false
        
        self.presentViewController(imagePC, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        print("El usuario ha elegido una foto")
        self.pickedImage.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
        //Parse.setApplicationId("y3h39K2E7w3NjlIp4tHcBQslM64svj0Zr59V2jNG", clientKey: "0xQIJhRlnYwZrBBWSG0Vt63NS0gRa6tFAVSkCdZK")
        
//        let score = PFObject(className: "score")
//        
//        score.setObject("David", forKey: "name")
//        score.setObject(95, forKey: "number")
//        
//        score.saveInBackgroundWithBlock { (success, error) -> Void in
//            if success {
//                print("El objeto score ha sido creado con ID \(score.objectId!)")
//            }
//            else {
//                print(error)
//            }
//        }
        
        
//        let query = PFQuery(className: "score")
//        query.getObjectInBackgroundWithId("LA1qpYwkaw") { (score: PFObject?, error) -> Void in
//            if error == nil {
//                score!["name"] = "Hola amigo"
//                score!["number"] = 53
//                
//                score?.saveInBackgroundWithBlock({ (success, error) -> Void in
//                    if success {
//                        print(score)
//                    }
//                    else {
//                        print(error)
//                    }
//                })
//            }
//            else {
//                print(error)
//            }
//        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
