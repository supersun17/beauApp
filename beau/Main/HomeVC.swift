//
//  MainFunctionSelectVC.swift
//  beau
//
//  Created by Ming Sun on 4/6/16.
//  Copyright © 2016 UDECE. All rights reserved.
//

import UIKit


class HomeVC: UIViewController {
    
    var collectionVC: CollectionVC?
    var settingTVC: SettingTVC?
    var searchVC: SearchVC?
    @IBOutlet weak var statusWindowView: UIView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var settingButton: UIButton!
    let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.size.height

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
    
    func toggleSettingVC() {
        if self.settingTVC == nil {
            self.settingTVC = self.storyboard?.instantiateViewControllerWithIdentifier("SettingTVC") as? SettingTVC
            
            self.settingTVC!.view.frame = CGRectMake(
                self.view.frame.size.width - 80,
                self.settingButton!.frame.maxY + statusBarHeight,
                80,
                self.view.frame.size.height - self.settingButton!.frame.maxY - statusBarHeight
            )
            self.addChildViewController(self.settingTVC!)
            self.view.addSubview(self.settingTVC!.view)
            self.settingTVC!.didMoveToParentViewController(self)
            self.settingTVC!.homeVC = self
            self.settingButton.setTitle("-", forState: UIControlState.Normal)
        } else if settingTVC!.view.frame.maxX == self.view.frame.size.width {
            self.settingTVC!.view.transform = CGAffineTransformTranslate(self.settingTVC!.view.transform, 80, 0)
            self.settingButton.setTitle("+", forState: UIControlState.Normal)
        } else {
            self.settingTVC!.view.transform = CGAffineTransformTranslate(self.settingTVC!.view.transform, -80, 0)
            self.settingButton.setTitle("-", forState: UIControlState.Normal)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func settingButtonPressed(sender: UIButton) {
        
        toggleSettingVC()
        
    }

    
    
}
