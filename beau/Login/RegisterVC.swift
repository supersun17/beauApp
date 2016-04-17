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

class RegisterVC: ImagedVC {
    
    @IBOutlet weak var userEmailText: UITextField!
    @IBOutlet weak var userNameText: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    
    override func viewDidLoad() {
        userPassword.secureTextEntry = true
        
        
        
    }
    
    
    @IBAction func submitButtonPressed(sender: UIButton) {
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
                    self.performSegueWithIdentifier("RegSuccessSegue", sender: self)
                }
                
            case .Failure(let error):
                print("Request failed with error: \(error)")
                }
        }
    }
    
}
