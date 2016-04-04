//
//  FeedTableTableViewController.swift
//  Instagram
//
//  Created by David Santiago on 4/4/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class FeedTableTableViewController: UITableViewController {
    
    var titles: [String] = []
    var usernames: [String] = []
    var images: [PFFile] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // cogemos unicamente los post de los usuarios que estoy siguiendo
        let getFollowedQuery = PFQuery(className:"followers")
        getFollowedQuery.whereKey("follower", equalTo: (PFUser.currentUser()!).username! )
        getFollowedQuery.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                if let objects = objects {
                    var followedUser = ""
                    for object in objects {
                        followedUser = object["following"] as! String
                        
                        let query = PFQuery(className:"Post")
                        query.whereKey("username", equalTo: followedUser)
                        query.findObjectsInBackgroundWithBlock {
                            (objects: [PFObject]?, error: NSError?) -> Void in
                            
                            if error == nil {
                                if let objects = objects {
                                    for object in objects {
                                        self.titles.append(object["title"] as! String)
                                        self.usernames.append(object["username"] as! String)
                                        self.images.append(object["imageFile"] as! PFFile)
                                    }
                                    
                                    self.tableView.reloadData()
                                }
                            } else {
                                print("Error: \(error!) \(error!.userInfo)")
                            }
                        }
                        
                    }
                }
            } else {
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return titles.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FeedCell", forIndexPath: indexPath) as! FeedCell

        cell.title.text = self.titles[indexPath.row]
        cell.username.text = self.usernames[indexPath.row]
        
        // hacemos esto para que descargue las imágenes en segundo plano
        self.images[indexPath.row].getDataInBackgroundWithBlock { (imageData: NSData?, error: NSError?) in
            if error == nil {
                let image = UIImage(data: imageData!)
                cell.postImage.image = image
            }
        }

        return cell
    }
    

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 250
    }

}
