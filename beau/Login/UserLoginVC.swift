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

class UserLoginVC: ImagedVC, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var userEmailText: UITextField!
    @IBOutlet weak var userPWText: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var dropdownMenu: UITableView!
    
    var userEmailList: [String] = []
    
    
    override func viewDidLoad() {
        userPWText.secureTextEntry = true
        
        self.dropdownMenu.hidden = true
        self.dropdownMenu.separatorColor = UIColor.clearColor()
        
        let user = load()
        
        if user.count > 1 {
            for userData in user {
                userEmailList.append(userData.valueForKey("userEmail") as! String)
                
                dropdownMenu.reloadData()
            }
            let lastUserIndex = userEmailList.count - 1
            userEmailText.text = userEmailList[lastUserIndex]
        }
        
        userEmailText.returnKeyType = UIReturnKeyType.Next
        userPWText.returnKeyType = UIReturnKeyType.Send
        userEmailText.delegate = self
        userPWText.delegate = self
        
        loginButton.layer.cornerRadius = GlobalVar.buttonRadius
        loginButton.setTitleColor(UIColor.clearColor(), forState: UIControlState.Disabled)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userEmailList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("dropdownTVCell", forIndexPath: indexPath)
        cell.textLabel!.text = userEmailList[indexPath.row]
        tableView.rowHeight = 21
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        userEmailText.text = userEmailList[indexPath.row]
        self.dropdownMenu.hidden = true
    }
    
    @IBAction func loginButtonPressed(sender: UIButton) {
        loadingIndicator.startAnimating()
        loginButton.enabled = false

        let url = "\(GlobalVar.apiUrl)/login"
        let parameters: Dictionary <String, String>? = [
            "userEmail": userEmailText.text!,
            "password": userPWText.text!
            //"deviceID": GlobalVar.generatUUID()
        ]
        
        //for tester
        
        Alamofire.request(.POST, url, parameters: parameters).responseString
            { response in switch response.result {
            case .Success(let json):
                print("Success with JSON: \(json)")
                switch(json) {
                case "Success":
                    self.save(self.userEmailText.text!)
                    self.performSegueWithIdentifier("LoginSuccessSegue", sender: self)
                case "Please enter password":
                    self.popAlert("Please enter password")
                case "Invalid password":
                    self.popAlert("Invalid password")
                case "Please register first":
                    self.popAlert("Email not found")
                default:
                    break
                }
                
            case .Failure(let error):
                print("Request failed with error: \(error)")
                }
            self.loadingIndicator.stopAnimating()
            self.loginButton.enabled = true
        }
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if textField == userEmailText {
            self.dropdownMenu.hidden = false
        }
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if textField == userEmailText {
            self.dropdownMenu.hidden = true
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == userEmailText {
            textField.resignFirstResponder()
            userPWText.becomeFirstResponder()
        }
        if textField == userPWText {
            textField.resignFirstResponder()
            loginButton.sendActionsForControlEvents(UIControlEvents.TouchUpInside)
        }
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func popAlert(info: String) {
        let alert = UIAlertController(title: info, message: nil, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler:nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func backButtonPressed(sender: UIButton) {
        self.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func save(email: String) {
        let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        let entityDescription = NSEntityDescription.entityForName("User", inManagedObjectContext: managedObjectContext)
        let user = User(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext)
        
        user.userEmail = email
        
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
