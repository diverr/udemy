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
        
        let newUser = NSEntityDescription.insertNewObjectForEntityForName("Users", inManagedObjectContext: context)
        
        newUser.setValue("David", forKey: "username")
        newUser.setValue("pass", forKey: "password")
        
        do {
            try context.save()
        } catch let error {
            print(error)
        }
        
        let request = NSFetchRequest(entityName: "Users")
        
        let results = try? context.executeFetchRequest(request)
        
        print(results)
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

