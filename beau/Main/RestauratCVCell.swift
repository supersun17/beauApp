//
//  CollectionVCell.swift
//  beau
//
//  Created by Ming Sun on 4/7/16.
//  Copyright © 2016 UDECE. All rights reserved.
//

import UIKit

class RestauratCVCell: UICollectionViewCell {
    
    var merchantID: Int?
    @IBOutlet weak var merchantLogoImage: UIImageView!
    @IBOutlet weak var progressBar: UIProgressView!
    
    override func awakeFromNib() {
        progressBar.progress = 0.0
    }
    
}