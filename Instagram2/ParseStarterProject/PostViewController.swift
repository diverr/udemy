//
//  PostViewController.swift
//  Instagram
//
//  Created by David Santiago on 1/4/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class PostViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var photoSelected: Bool = false
    
    @IBOutlet weak var imageToPost: UIImageView!
    
    @IBOutlet weak var shareText: UITextField!
    
    func displayAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "Aceptar", style: .Default, handler: { (action) in
            self.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func postImage(sender: AnyObject) {
        var error = ""
        
        if !self.photoSelected {
            error = "Por favor elige una imagen"
        }
        else if shareText.text == "" {
            error = "Por favor escribe un texto"
        }
        
        if error != "" {
            self.displayAlert("Error en los datos", message: error)
        }
        else {
            let post = PFObject(className: "Post")
            post["title"] = shareText.text
            
            // vamos con la imagen
            let imageData = UIImagePNGRepresentation(self.imageToPost.image!)
            let imageFile = PFFile(name: "image.png", data: imageData!)
            post["imageFile"] = imageFile
            post["username"] = PFUser.currentUser()?.username
            
            self.activityIndicator.startAnimating()
            UIApplication.sharedApplication().beginIgnoringInteractionEvents()
            
            post.saveInBackgroundWithBlock({ (success, error) in
                if success {
                    self.displayAlert("Publicación completada", message: "Tu foto ha sido completada con éxito")
                }
                else {
                    self.displayAlert("No se pudo publicar", message: "No se pudo subir los datos")
                }
                
                self.photoSelected = false
                self.shareText.text = ""
                self.imageToPost.image = UIImage(named: "Silueta-MAS.jpg")
                
                self.activityIndicator.stopAnimating()
                UIApplication.sharedApplication().endIgnoringInteractionEvents()
                
            })
        }
        
    }
    
    @IBAction func chooseImage(sender: AnyObject) {
        let picker = UIImagePickerController()
        picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        picker.allowsEditing = false
        picker.delegate = self
        
        self.presentViewController(picker, animated: true, completion: nil)
    }
    
    @IBAction func logOut(sender: AnyObject) {
        PFUser.logOut()
        self.performSegueWithIdentifier("logout", sender: self)
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.imageToPost.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
        self.photoSelected = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.activityIndicator.stopAnimating()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
