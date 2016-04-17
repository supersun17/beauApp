//
//  MainPageVC.swift
//  beau
//
//  Created by Ming Sun on 4/6/16.
//  Copyright © 2016 UDECE. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreData

class UserLoginVC: ImagedVC {

    @IBOutlet weak var userEmailText: UITextField!
    @IBOutlet weak var userPWText: UITextField!
    
    override func viewDidLoad() {
        userPWText.secureTextEntry = true
        
        let user = load()
        if user.count != 0 {
           userEmailText.text = user[0].valueForKey("email") as? String
        }
    }
    
    @IBAction func loginButtonPressed(sender: UIButton) {
        let url = "\(GlobalVar.apiUrl)/login"
        let parameters: Dictionary <String, String>? = [
            "email": userEmailText.text!,
            "password": userPWText.text!,
            "deviceID": GlobalVar.generatUUID()
        ]
        
        Alamofire.request(.POST, url, parameters: parameters).responseString
            { response in switch response.result {
            case .Success(let json):
                print("Success with JSON: \(json)")
                
                if json == "success" {
                    print("success")
                    self.save(self.userEmailText.text!)
                    self.performSegueWithIdentifier("LoginSuccessSegue", sender: self)
                }
                
            case .Failure(let error):
                print("Request failed with error: \(error)")
                }
        }
    }
    
    func save(email: String) {
        let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        let entityDescription = NSEntityDescription.entityForName("User", inManagedObjectContext: managedObjectContext)
        let user = User(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext)
        
        user.email = email
        
        do {
            try managedObjectContext.save()
            print("Saved")
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    func load() -> [NSManagedObject] {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "User")
        var User: [NSManagedObject]?
        
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            User = results as? [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        return User!
    }

    
    
}
