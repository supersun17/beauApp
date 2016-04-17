//
//  CollectionVC.swift
//  beau
//
//  Created by Ming Sun on 4/7/16.
//  Copyright © 2016 UDECE. All rights reserved.
//

import UIKit

class CollectionVC: UICollectionViewController {
    
    private let reusableCell = "RestauratCVCell"
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reusableCell, forIndexPath: indexPath) as! RestauratCVCell
        //cell.backgroundColor = UIColor.blackColor()
        // Configure the cell
        return cell
    }
    
    
}