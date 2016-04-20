//
//  beauRoundCornerView.swift
//  beau
//
//  Created by Ming Sun on 4/20/16.
//  Copyright © 2016 UDECE. All rights reserved.
//

import UIKit

class beauRoundCornerView: UIView {
    
    override func drawRect(rect: CGRect) {
        self.layer.cornerRadius = 6
        self.clipsToBounds = true
    }
}
