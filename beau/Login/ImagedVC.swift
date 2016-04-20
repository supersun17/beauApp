//
//  ImagedVC.swift
//  beau
//
//  Created by Ming Sun on 4/8/16.
//  Copyright © 2016 UDECE. All rights reserved.
//

import UIKit

class ImagedVC: UIViewController {
    
    var backGroundImgView = UIImageView()
    override func viewWillAppear(animated: Bool) {
        
        backGroundImgView.image = UIImage(named: "white_ink")
        backGroundImgView.contentMode = UIViewContentMode.ScaleAspectFill
        
        backGroundImgView.frame = CGRectMake(
            0,
            0,
            self.view.frame.size.width,
            self.view.frame.size.height
        )
        self.view.addSubview(backGroundImgView)
        self.view.sendSubviewToBack(backGroundImgView)
    }
    
}
