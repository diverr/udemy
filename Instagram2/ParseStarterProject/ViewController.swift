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
    
    var loading = UIActivityIndicatorView()
    
    var signUpActive = true
    
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    
    @IBOutlet weak var signUpToggleButton: UIButton!
    
    @IBOutlet weak var alreadyRegistered: UILabel!
    
    @IBOutlet weak var signUpLabel: UILabel!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    
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
            
            // loader
            loading.center = self.view.center
            loading.hidesWhenStopped = true
            loading.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
            loading.startAnimating()
            
            self.view.addSubview(loading)
            
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            
            
            
            if signUpActive == true {
                
                let user = PFUser()
                user.username = self.username.text
                user.password = self.password.text
                
                user.signUpInBackgroundWithBlock {
                    (succeeded: Bool, signUpError: NSError?) -> Void in
                    
                    // ocultamos el loader
                    self.loading.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    
                    if signUpError == nil {
                        print("Usuario registrado")
                        self.performSegueWithIdentifier("jumpToUsersTable", sender: self)
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
            else {
                
                PFUser.logInWithUsernameInBackground(self.username.text!, password: self.password.text!) {
                    (user: PFUser?, loginError: NSError?) -> Void in
                    
                    // ocultamos el loader
                    self.loading.stopAnimating()
                    UIApplication.sharedApplication().endIgnoringInteractionEvents()
                    
                    if user != nil {
                        print("El usuario ha accedido")
                        self.performSegueWithIdentifier("jumpToUsersTable", sender: self)
                    } else {
                        
                        if let errorString = loginError!.userInfo["error"] as? NSString {
                            self.displayAlert("Error al acceder", message: errorString as String)
                        }
                        else {
                            self.displayAlert("Error al acceder", message: "Por favor reinténtalo")
                        }
                        
                    }
                }
                
            }
            
            
            
            
            
            
            
        }
        
        if error != "" {
            self.displayAlert("Error en formulario", message: error)
        }
        
    }
    
    
    
    @IBAction func signUpToggle(sender: AnyObject) {
        if signUpActive == true {
            // Estoy en modo registro, voy a modo acceso
            self.signUpToggleButton.setTitle("Registrarse", forState: .Normal)
            self.alreadyRegistered.text = "¿No registrado?"
            self.signUpButton.setTitle("Acceder", forState: .Normal)
            self.signUpLabel.text = "Usa el formulario inferior para acceder"
            
            signUpActive = false
        }
        else {
            // Estoy en modo acceso, voy a modo registro
            self.signUpToggleButton.setTitle("Acceder", forState: .Normal)
            self.alreadyRegistered.text = "¿Ya registrado?"
            self.signUpButton.setTitle("Registrar  nuevo usuario", forState: .Normal)
            self.signUpLabel.text = "Usa el formulario inferior para registrarte"
            
            signUpActive = true
        }
    }
    
    @IBAction func didLogOut(segue: UIStoryboardSegue) {
        print("Logout")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if PFUser.currentUser() != nil {
            self.performSegueWithIdentifier("jumpToUsersTable", sender: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
