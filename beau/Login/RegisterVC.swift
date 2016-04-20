//
//  RegisterVC.swift
//  beau
//
//  Created by Ming Sun on 4/7/16.
//  Copyright © 2016 UDECE. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftValidator
import CoreData

class RegisterVC: ImagedVC, UITextFieldDelegate, ValidationDelegate {
    
    @IBOutlet weak var userEmailText: UITextField!
    @IBOutlet weak var userNameText: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var userPasswordConfirm: UITextField!
    
    @IBOutlet weak var submitButton: UIButton!
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var nameErrorLabel: UILabel!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    @IBOutlet weak var pwdConfirmErrorLabel: UILabel!
    
    var keyBoardHeight:CGFloat?
    
    let validator = Validator()
    
    override func viewDidLoad() {
        userPassword.secureTextEntry = true
        userPasswordConfirm.secureTextEntry = true
        
        userEmailText.returnKeyType = UIReturnKeyType.Next
        userNameText.returnKeyType = UIReturnKeyType.Next
        userPassword.returnKeyType = UIReturnKeyType.Next
        userPasswordConfirm.returnKeyType = UIReturnKeyType.Send
        
        userEmailText.delegate = self
        userNameText.delegate = self
        userPassword.delegate = self
        userPasswordConfirm.delegate = self
        
        validator.registerField(userEmailText, errorLabel: emailErrorLabel, rules: [RequiredRule(), EmailRule(message: "Invalid Email format")])
        validator.registerField(userNameText, errorLabel: nameErrorLabel, rules: [RequiredRule(), FullNameRule(message:"First name Last name")])
        validator.registerField(userPassword, errorLabel: passwordErrorLabel, rules: [RequiredRule(), PasswordRule(message:"Must be 8 characters with 1 uppercase")])
        validator.registerField(userPasswordConfirm, errorLabel: pwdConfirmErrorLabel, rules: [ConfirmationRule(confirmField :userPassword, message:"Incompatible password")])
        
        submitButton.layer.cornerRadius = GlobalVar.buttonRadius
        
        hideAllErrorLabel()
        
    }
    
    func hideAllErrorLabel() {
        emailErrorLabel.hidden = true
        nameErrorLabel.hidden = true
        passwordErrorLabel.hidden = true
        pwdConfirmErrorLabel.hidden = true
    }
    
    
    @IBAction func submitButtonPressed(sender: UIButton) {
        if validator.errors.count != 0 {
            for (field, error) in validator.errors {
                field.layer.borderColor = UIColor.clearColor().CGColor
                field.layer.borderWidth = 0.0
                error.errorLabel?.text = error.errorMessage
                error.errorLabel?.hidden = true
            }
        }
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            self.view.transform = CGAffineTransformMakeTranslation(0, 0)
        })
        validator.validate(self)
    }
    
    func validationSuccessful() {
        loadingIndicator.startAnimating()
        let url = "\(GlobalVar.apiUrl)/reg"
        let parameters: Dictionary <String, String>? = [
            "email": userEmailText.text!,
            "password": userPassword.text!,
            "username": userNameText.text!
        ]
        
        Alamofire.request(.POST, url, parameters: parameters).responseString
            { response in switch response.result {
            case .Success(let json):
                print("Success with JSON: \(json)")
                
                if json == "success" {
                    print("success")
                    self.save(self.userEmailText.text!)
                    self.performSegueWithIdentifier("RegSuccessSegue", sender: self)
                    self.loadingIndicator.stopAnimating()
                }
                
            case .Failure(let error):
                print("Request failed with error: \(error)")
                self.loadingIndicator.stopAnimating()
                }
        }
    }
    
    func validationFailed(errors:[UITextField:ValidationError]) {
        print("not validate")
        
        for (field, error) in validator.errors {
            field.layer.borderColor = UIColor.purpleColor().CGColor
            field.layer.borderWidth = 2.0
            error.errorLabel?.text = error.errorMessage
            error.errorLabel?.hidden = false
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        switch(textField) {
            case userEmailText:
                textField.resignFirstResponder()
                userNameText.becomeFirstResponder()
            case userNameText:
                textField.resignFirstResponder()
                userPassword.becomeFirstResponder()
            case userPassword:
                textField.resignFirstResponder()
                userPasswordConfirm.becomeFirstResponder()
            case userPasswordConfirm:
                textField.resignFirstResponder()
                submitButton.sendActionsForControlEvents(UIControlEvents.TouchUpInside)
            default:
                break
        }
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
        if self.view.frame.maxY < self.view.frame.height {
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                self.view.transform = CGAffineTransformMakeTranslation(0, 0)
            })
        }
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        switch(textField) {
        case userEmailText:
            let shift = userEmailText.frame.maxY - textField.frame.maxY
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                self.view.transform = CGAffineTransformMakeTranslation(0, shift)
            })
        case userNameText:
            let shift = userEmailText.frame.maxY - textField.frame.maxY
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                self.view.transform = CGAffineTransformMakeTranslation(0, shift)
            })
        case userPassword:
            let shift = userEmailText.frame.maxY - textField.frame.maxY
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                self.view.transform = CGAffineTransformMakeTranslation(0, shift)
            })
        case userPasswordConfirm:
            let shift = userEmailText.frame.maxY - textField.frame.maxY
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                self.view.transform = CGAffineTransformMakeTranslation(0, shift)
            })
        default:
            break
        }
        return true
    }
    
    @IBAction func backButtonPressed(sender: UIButton) {
        self.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        self.dismissViewControllerAnimated(true, completion: nil)
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
    
    
}
