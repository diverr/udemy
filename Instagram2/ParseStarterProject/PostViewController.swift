//
//  PostViewController.swift
//  Instagram
//
//  Created by David Santiago on 31/3/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit

class PostViewController: ViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    
    var photoSelected: Bool = false
    
    @IBOutlet weak var imageToPost: UIImageView!
    
    @IBOutlet weak var shareText: UITextField!
    
    @IBAction func postImage(sender: AnyObject) {
        
    }
    
    @IBAction func chooseImage(sender: AnyObject) {
        var picker = UIImagePickerController()
        picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        picker.allowsEditing = false
        picker.delegate = self
        
        self.presentViewController(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.imageToPost.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
        self.photoSelected = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
