//
//  MasterCollectionLayout.swift
//  TJMobile
//
//  Created by 田程元 on 14/12/18.
//  Copyright (c) 2014年 田程元. All rights reserved.
//

import UIKit

class MasterCollectionLayout: UICollectionViewLayout {
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes! {
        var attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
        attributes.frame.size = CGSizeMake((collectionView?.bounds)!.width/3-1, (collectionView?.bounds)!.width/3-1)
        attributes.frame.origin.x = (collectionView?.bounds)!.width/3*CGFloat(indexPath.row%3)
        attributes.frame.origin.y = (collectionView?.bounds)!.width/3*CGFloat(indexPath.row/3)
        attributes.zIndex = zIndexForPassAtIndex(indexPath);
        println(attributes.frame)
        return attributes;
        
    }
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [AnyObject]? {
        var cells = NSMutableArray(capacity: cards.count)
        for (var i = 0;i < cards.count;i++){
            cells[i] = self.layoutAttributesForItemAtIndexPath(NSIndexPath(forRow: i, inSection: 0))
        }
        return cells as [AnyObject];
    }
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return false
    }
    override func collectionViewContentSize() -> CGSize {
        println(collectionView?.frame)
        return CGSizeMake((collectionView?.bounds)!.width, (CGFloat(cards.count/3)+1)*((collectionView?.bounds)!.width/3))
    }
    func zIndexForPassAtIndex(indexPath:NSIndexPath )->NSInteger{
        return indexPath.item
    }
}
