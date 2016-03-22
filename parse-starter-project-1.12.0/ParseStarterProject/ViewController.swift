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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        Parse.setApplicationId("y3h39K2E7w3NjlIp4tHcBQslM64svj0Zr59V2jNG", clientKey: "0xQIJhRlnYwZrBBWSG0Vt63NS0gRa6tFAVSkCdZK")
        
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
        
        
        let query = PFQuery(className: "score")
        query.getObjectInBackgroundWithId("LA1qpYwkaw") { (score: PFObject?, error) -> Void in
            if error == nil {
                score!["name"] = "Hola amigo"
                score!["number"] = 53
                
                score?.saveInBackgroundWithBlock({ (success, error) -> Void in
                    if success {
                        print(score)
                    }
                    else {
                        print(error)
                    }
                })
            }
            else {
                print(error)
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
