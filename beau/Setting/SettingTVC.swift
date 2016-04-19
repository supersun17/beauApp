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
            case 0:
                self.dismissViewControllerAnimated(false, completion: nil)
            case 1:
                self.performSegueWithIdentifier("UpdateInfoSegue", sender: self)
            default:
                break
        
        }
    }

}
