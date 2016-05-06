//
//  SearchVC.swift
//  beau
//
//  Created by Ming Sun on 4/7/16.
//  Copyright © 2016 UDECE. All rights reserved.
//

import UIKit

class SearchVC: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    var homeVC: HomeVC?
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchResultTV: UITableView!
    @IBOutlet weak var ViewsContainerView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    
    override func viewDidLoad() {
        closeButton.layer.cornerRadius = closeButton.frame.width/2
        closeButton.layer.borderColor = UIColor.whiteColor().CGColor
        closeButton.layer.borderWidth = 1.0
        searchResultTV.backgroundColor = UIColor(patternImage: UIImage(named: "semi_transparent")!)
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        print("start search texting")
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RestaurantTVCell", forIndexPath: indexPath) as! RestaurantTVCell
        cell.titleLabel.text = "Prototype"
        return cell
    }
    
    @IBAction func closeButton(sender: UIButton) {
        self.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
