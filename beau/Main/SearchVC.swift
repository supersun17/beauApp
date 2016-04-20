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
    
    private let reusableCell = "RestaurantTVCell"
    
    override func viewDidLoad() {
        closeButton.layer.cornerRadius = closeButton.frame.width/2
        searchResultTV.backgroundColor = UIColor(patternImage: UIImage(named: "semi_transparent")!)
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        print("start search texting")
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reusableCell, forIndexPath: indexPath) as! RestaurantTVCell
        cell.titleLabel.text = "show"
        return cell
    }
    
    @IBAction func closeButton(sender: UIButton) {
        self.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
