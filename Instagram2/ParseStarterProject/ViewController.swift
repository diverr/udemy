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

class ViewController: UIViewController {

    
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @available(iOS 8.0, *)
    func displayAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: .Default, handler: { (action) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @available(iOS 8.0, *)
    @IBAction func signUp(sender: AnyObject) {
        var error = ""
        
        if self.username.text == "" || self.password.text == "" {
            error = "Introduce un usuario y contraseña"
        }
        else {
            
            let user = PFUser()
            user.username = self.username.text
            user.password = self.password.text
            
            user.signUpInBackgroundWithBlock {
                (succeeded: Bool, signUpError: NSError?) -> Void in
                
                if signUpError == nil {
                    print("Usuario registrado")
                }
                else {
                    if let errorString = signUpError!.userInfo["error"] as? NSString {
                        self.displayAlert("Error en formulario", message: errorString as String)
                    }
                    else {
                        self.displayAlert("Error en formulario", message: "Por favor reinténtalo")
                    }
                }
                
            }
            
        }
        
        if error != "" {
            self.displayAlert("Error en formulario", message: error)
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
