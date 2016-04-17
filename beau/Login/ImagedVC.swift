//
//  ImagedVC.swift
//  beau
//
//  Created by Ming Sun on 4/8/16.
//  Copyright © 2016 UDECE. All rights reserved.
//

import UIKit

class ImagedVC: UIViewController {
    
    override func viewWillAppear(animated: Bool) {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Welcome.png")!)
    }
    
}
