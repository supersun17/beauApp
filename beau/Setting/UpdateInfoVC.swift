//
//  UpdateInfoVC.swift
//  beau
//
//  Created by Ming Sun on 4/8/16.
//  Copyright © 2016 UDECE. All rights reserved.
//

import UIKit

class UpdateInfoVC: ImagedVC {
    
    @IBAction func backButtonPressed(sender: AnyObject) {
        self.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
