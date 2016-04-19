//
//  SettingVC.swift
//  beau
//
//  Created by Ming Sun on 4/7/16.
//  Copyright © 2016 UDECE. All rights reserved.
//

import UIKit

class SettingTVC: UITableViewController {
    
    var homeVC: HomeVC?
    
    override func viewDidLoad() {
        
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch(indexPath.row) {
            
            case 1:
                self.performSegueWithIdentifier("UpdateInfoSegue", sender: self)
            case 4:
                self.dismissViewControllerAnimated(false, completion: nil)
            default:
                break
        
        }
    }

}
