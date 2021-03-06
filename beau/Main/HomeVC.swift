//
//  MainFunctionSelectVC.swift
//  beau
//
//  Created by Ming Sun on 4/6/16.
//  Copyright © 2016 UDECE. All rights reserved.
//

import UIKit


class HomeVC: ImagedVC {
    
    var collectionVC: CollectionVC?
    var searchVC: SearchVC?
    @IBOutlet weak var statusWindowView: UIView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var settingButton: UIButton!
    let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.size.height

    override func viewDidLoad() {
        super.viewDidLoad()
        self.statusWindowView.backgroundColor = UIColor(patternImage: UIImage(named: "Wavy_lines.png")!)
        
        initCollectionVC()
    }
    
    func initCollectionVC() {
        self.collectionVC = self.storyboard?.instantiateViewControllerWithIdentifier("CollectionVC") as? CollectionVC
        
        self.collectionVC!.view.frame = CGRectMake(
            6,
            self.statusWindowView!.frame.maxY + 6,
            self.view.frame.size.width - 12,
            self.view.frame.size.height - self.statusWindowView!.frame.maxY - 6
        )
        self.addChildViewController(self.collectionVC!)
        self.view.addSubview(self.collectionVC!.view)
        self.collectionVC!.didMoveToParentViewController(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
}
