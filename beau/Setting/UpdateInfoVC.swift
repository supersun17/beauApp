//
//  UpdateInfoVC.swift
//  beau
//
//  Created by Ming Sun on 4/8/16.
//  Copyright © 2016 UDECE. All rights reserved.
//

import UIKit

class UpdateInfoVC: ImagedVC, UITextFieldDelegate {
    @IBOutlet weak var originPassword: UITextField!
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var confirmNewPassword: UITextField!
    @IBOutlet weak var updateEmail: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        submitButton.layer.cornerRadius = GlobalVar.buttonRadius
        
        originPassword.returnKeyType = UIReturnKeyType.Next
        newPassword.returnKeyType = UIReturnKeyType.Next
        confirmNewPassword.returnKeyType = UIReturnKeyType.Next
        updateEmail.returnKeyType = UIReturnKeyType.Send
        
        originPassword.delegate = self
        newPassword.delegate = self
        confirmNewPassword.delegate = self
        updateEmail.delegate = self
    }
    
    @IBAction func backButtonPressed(sender: AnyObject) {
        self.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        switch(textField) {
        case originPassword:
            textField.resignFirstResponder()
            newPassword.becomeFirstResponder()
        case newPassword:
            textField.resignFirstResponder()
            confirmNewPassword.becomeFirstResponder()
        case confirmNewPassword:
            textField.resignFirstResponder()
            updateEmail.becomeFirstResponder()
        case updateEmail:
            textField.resignFirstResponder()
            self.view.endEditing(true)
        default:
            break
        }
        return true
    }
    
}
