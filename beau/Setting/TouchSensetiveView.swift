//
//  TouchSensetiveView.swift
//  beau
//
//  Created by Ming Sun on 4/21/16.
//  Copyright © 2016 UDECE. All rights reserved.
//

import UIKit

class TouchSensetiveView: UIView {
    
    var settingVC: SettingVC?
    
    override func drawRect(rect: CGRect) {
    
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        settingVC?.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
