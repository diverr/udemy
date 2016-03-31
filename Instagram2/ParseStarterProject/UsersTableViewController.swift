//
//  UsersTableViewController.swift
//  Instagram
//
//  Created by David Santiago Fdez-Bermejo Morales on 30/3/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit
import Parse

class UsersTableViewController: UITableViewController {
    
    var users: [String] = []
    var following: [Bool] = []
    var refresher: UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refresher = UIRefreshControl()
        self.refresher.attributedTitle = NSAttributedString(string: "Arrastra para recargar")
        self.refresher.addTarget(self, action: #selector(UsersTableViewController.refresh), forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(self.refresher)
        
        self.updateUsers()
    }
    
    func refresh() {
        self.updateUsers()
    }
    
    func updateUsers() {
        let followingQuery = PFQuery(className:"followers")
        followingQuery.whereKey("follower", equalTo:(PFUser.currentUser()?.username)!)
        
        followingQuery.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                if let followingPeople = objects {
                    
                    let query = PFUser.query()
                    query?.findObjectsInBackgroundWithBlock({ (objects, error) in
                        
                        self.users.removeAll(keepCapacity: true)
                        self.following.removeAll(keepCapacity: true)
                        
                        for object in objects! {
                            let user: PFUser = object as! PFUser
                            if user.username != PFUser.currentUser()?.username {
                                self.users.append(user.username!)
                                
                                var isFollowing = false
                                for followingPerson in followingPeople {
                                    if followingPerson["following"] as? String == user.username {
                                        isFollowing = true
                                    }
                                }
                                
                                self.following.append(isFollowing)
                            }
                            
                            
                        }
                        self.tableView.reloadData()
                        self.refresher.endRefreshing()
                    })
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
                self.refresher.endRefreshing()
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
        return self.users.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        cell.textLabel?.text = self.users[indexPath.row]
        
        if following[indexPath.row] {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        }
        else {
            cell.accessoryType = UITableViewCellAccessoryType.None
        }

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell: UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        
        if cell.accessoryType == UITableViewCellAccessoryType.Checkmark {
            cell.accessoryType = UITableViewCellAccessoryType.None
            
            let query = PFQuery(className:"followers")
            query.whereKey("follower", equalTo:(PFUser.currentUser()?.username)!)
            query.whereKey("following", equalTo:cell.textLabel!.text!)
            
            query.findObjectsInBackgroundWithBlock {
                (objects: [PFObject]?, error: NSError?) -> Void in
                
                if error == nil {
                    if let objects = objects {
                        for object in objects {
                            object.deleteInBackgroundWithBlock(nil)
                        }
                    }
                } else {
                    // Log details of the failure
                    print("Error: \(error!) \(error!.userInfo)")
                }
            }

        }
        else {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            
            var following = PFObject(className: "followers")
            following["following"] = cell.textLabel?.text
            following["follower"] = PFUser.currentUser()?.username
            following.saveInBackgroundWithBlock(nil)
        }
        
        
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
