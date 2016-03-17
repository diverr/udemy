//
//  ViewController.swift
//  Demo de Core Data
//
//  Created by David Santiago on 15/3/16.
//  Copyright © 2016 David Santiago. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let context: NSManagedObjectContext = appDel.managedObjectContext
        
        //let newUser = NSEntityDescription.insertNewObjectForEntityForName("Users", inManagedObjectContext: context)
        
        //newUser.setValue("Otro más2", forKey: "username")
        //newUser.setValue("23234234234", forKey: "password")
        
        //_ = try? context.save()
        
        let request = NSFetchRequest(entityName: "Users")
        
        if let results = try? context.executeFetchRequest(request) where results.count > 0 {
            for result in results {
                if let username = result.valueForKey("username"),
                    let password = result.valueForKey("password")
                    where username as? String == "David" {
                    print(password)
                        
                    context.deleteObject(result as! NSManagedObject)
                }
            }
            
            _ = try? context.save()
        }
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

