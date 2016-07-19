//
//  ForgetPasswordVC.swift
//  beau
//
//  Created by Ming Sun on 4/7/16.
//  Copyright © 2016 UDECE. All rights reserved.
//

import UIKit
import SwiftValidator
import SwiftyJSON
import Alamofire

class ForgetPasswordVC: ImagedVC, UITextFieldDelegate, ValidationDelegate {
    
    @IBOutlet weak var actionTitle: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailErrorLabel: UILabel!
    
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var codeErrorLabel: UILabel!
    
    @IBOutlet weak var newPWTextField: UITextField!
    @IBOutlet weak var newPWErrorLabel: UILabel!
    
    @IBOutlet weak var cfPWTextField: UITextField!
    @IBOutlet weak var cfPWErrorLabel: UILabel!
    
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var loadingAnm: UIActivityIndicatorView!
    
    let validator = Validator()
    
    override func viewDidLoad() {
        emailErrorLabel.hidden = true
        
        codeTextField.hidden = true
        codeErrorLabel.hidden = true
        
        newPWTextField.hidden = true
        newPWErrorLabel.hidden = true
        newPWTextField.secureTextEntry = true
        
        cfPWTextField.secureTextEntry = true
        cfPWTextField.hidden = true
        cfPWErrorLabel.hidden = true
        submitButton.layer.cornerRadius = GlobalVar.buttonRadius
        submitButton.setTitle("submit", forState: UIControlState.Normal)
        
        emailTextField.delegate = self
        codeTextField.delegate = self
        newPWTextField.delegate = self
        cfPWTextField.delegate = self
        
        
    }
    
    @IBAction func sendEmailPressed(sender: UIButton) {
        if validator.errors.count != 0 {
            for (field, error) in validator.errors {
                field.layer.borderColor = UIColor.clearColor().CGColor
                field.layer.borderWidth = 0.0
                error.errorLabel?.text = error.errorMessage
                error.errorLabel?.hidden = true
            }
        }
        if codeTextField.hidden == true {
            
            validator.registerField(emailTextField, errorLabel: emailErrorLabel, rules: [RequiredRule(), EmailRule(message: "Invalid Email format")])

        } else {
            validator.registerField(codeTextField, errorLabel: codeErrorLabel, rules: [RequiredRule(), ExactLengthRule(length: 4, message : "Must be a 4 digit code")])
            validator.registerField(newPWTextField, errorLabel: newPWErrorLabel, rules: [RequiredRule(), PasswordRule(message:"Must be 8 characters with 1 uppercase")])
            validator.registerField(cfPWTextField, errorLabel: cfPWErrorLabel, rules: [ConfirmationRule(confirmField :newPWTextField, message:"Incompatible password")])
        }
        
        validator.validate(self)
        
    }
    
    func validationSuccessful() {
        actionTitle.text! = "Succeed! Now please check your mail box and type in the 4 digit code below"
        submitButton.enabled = false
        let url = "\(GlobalVar.apiUrl)/forgetPW"
        if codeTextField.hidden == true {
            let parameters: Dictionary <String, String>? = [
                "email": emailTextField.text!,
                "password": "",
                "username": ""
            ]
            Alamofire.request(.POST, url, parameters: parameters).responseString
                { response in switch response.result {
                case .Success(let json):
                    print("Success with JSON: \(json)")
                    switch(json) {
                    case "success":
                        
                        self.codeTextField.hidden = true
                        self.newPWTextField.hidden = true
                        self.cfPWTextField.hidden = true
                        self.submitButton.enabled = true
                    default:
                        break
                    }
                case .Failure(let error):
                    print("Request failed with error: \(error)")
                    self.actionTitle.text! = "Error occurred"
                    self.submitButton.enabled = true
                    }
            }
        } else {
            self.actionTitle.text! = "New password is sent to the server, please wait"
            self.loadingAnm.startAnimating()
            let parameters: Dictionary <String, String>? = [
                "email": emailTextField.text!,
                "code": codeTextField.text!,
                "password": newPWTextField.text!,
                "username": cfPWTextField.text!
            ]
            Alamofire.request(.POST, url, parameters: parameters).responseString
                { response in switch response.result {
                case .Success(let json):
                    print("Success with JSON: \(json)")
                    switch(json) {
                    case "success":
                        self.loadingAnm.stopAnimating()
                        self.popAlert()
                    default:
                        break
                    }
                case .Failure(let error):
                    print("Request failed with error: \(error)")
                    self.actionTitle.text! = "Error occurred"
                    self.submitButton.enabled = true
                    }
            }
        }
    }
    
    func popAlert() {
        let alert = UIAlertController(title: "Reset succeed, move the main page?", message: nil, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: {
            (alert: UIAlertAction!) in self.performSegueWithIdentifier("PWresetSuccessSegue", sender: self)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler:nil))
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    func validationFailed(errors: [UITextField : ValidationError]) {
        print("not validate")
        for (field, error) in validator.errors {
            field.layer.borderColor = UIColor.purpleColor().CGColor
            field.layer.borderWidth = 2.0
            error.errorLabel?.text = error.errorMessage
            error.errorLabel?.hidden = false
        }
    }
    
    @IBAction func backButtonPressed(sender: UIButton) {
        self.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
