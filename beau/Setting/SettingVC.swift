//
//  SettingVC.swift
//  beau
//
//  Created by Ming Sun on 4/7/16.
//  Copyright © 2016 UDECE. All rights reserved.
//

import UIKit

class SettingVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var touchSensetiveView: TouchSensetiveView!
    
    override func viewDidLoad() {
        touchSensetiveView.settingVC = self
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SettingMenuTVCell", forIndexPath: indexPath) as! SettingMenuTVCell
        switch(indexPath.row) {
        case 0:
            cell.title.text = "Close X"
        case 1:
            cell.title.text = "User info"
        case 2:
            cell.title.text = "Help"
        case 3:
            cell.title.text = "Update"
        case 4:
            cell.title.text = "QR code"
        case 5:
            cell.title.text = "Logout"
        default:
            break
            
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)

    }
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        switch(indexPath.row) {
        case 0:
            self.dismissViewControllerAnimated(true, completion: nil)
        case 3:
            self.performSegueWithIdentifier("ToUpdateInfoSegue", sender: self)
        case 5:
            self.presentingViewController?.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
        default:
            break
            
        }
        
        return indexPath
    }
}
