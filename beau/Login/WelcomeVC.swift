//
//  File.swift
//  beau
//
//  Created by Ming Sun on 4/7/16.
//  Copyright © 2016 UDECE. All rights reserved.
//

import UIKit

class WelcomeVC: ImagedVC {
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    override func viewDidLoad() {
        loginButton.layer.cornerRadius = GlobalVar.buttonRadius
        signupButton.layer.cornerRadius = GlobalVar.buttonRadius
        
    }
}
