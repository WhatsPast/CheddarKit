//
//  ListsViewLayout.swift
//  CheddarKit
//
//  Created by Karl Weber on 1/2/18.
//  Copyright © 2018 Karl Weber. All rights reserved.
//

import UIKit

class ListsViewLayout: UICollectionViewLayout {
    
    let cellHeight: CGFloat = 44.0 + 15
    
    override var collectionViewContentSize : CGSize {
        let contentWidth: CGFloat = self.collectionView!.bounds.size.width
        var total = CGFloat((collectionView!.dataSource?.collectionView(collectionView!, numberOfItemsInSection: 0))!)
        let contentHeight: CGFloat = (cellHeight * total)
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    // Returns the layout attributes for all of the cells and views in the specified rectangle.
    // I would say that A little math here wouldn't hurt.
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var myRect = rect
        
        // always make the rect bigger.
        myRect = CGRect(x: rect.origin.x, y: 0, width: rect.width, height: rect.height + 500)
        
        var attributes = [UICollectionViewLayoutAttributes]()
        
        // iterate through every possible indexPath/cell in the whole dang thing
        // if it falls within the rect add it.
        for item in 0..<(collectionView!.numberOfItems(inSection: 0)) {
            let att = self.layoutAttributesForItem(at: IndexPath(item:item, section: 0))!
            if att.frame.intersects(myRect) {
                attributes.append(att)
            }
        }
        for item in 0..<(collectionView!.numberOfItems(inSection: 1)) {
            let att = self.layoutAttributesForItem(at: IndexPath(item:item, section: 1))!
            if att.frame.intersects(myRect) {
                attributes.append(att)
            }
        }
        return attributes
    }
    
    // Returns the layout attributes for the item at the specified index path.
    // This will probably have a little math too.
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        var ourCellHeight = cellHeight
        let cellPadding: CGFloat = 0
        let width: CGFloat = self.collectionView!.bounds.size.width
        
        // determine if it's odd or even
        let xPosition: CGFloat = 0
        var yPosition: CGFloat = 0
        let upperPadding: CGFloat = 0
        
        
        // for the regular cells
        if (indexPath as NSIndexPath).item > 0 {
            yPosition = CGFloat((indexPath as NSIndexPath).item) * (cellHeight + cellPadding) + upperPadding
        }
        
        // for the other rows
        if indexPath.section > 0 {
            var lastRowsFrame = CGRect(x:0, y:0, width:0, height: 0)
            let totalItems = collectionView!.numberOfItems(inSection: 0)
            if totalItems > 0 {
                let att = self.layoutAttributesForItem(at: IndexPath(item: totalItems - 1, section: 0))!
                lastRowsFrame = att.frame
            }
            
            yPosition = lastRowsFrame.origin.y + lastRowsFrame.size.height
            
            if (indexPath as NSIndexPath).item > 0 {
                yPosition = yPosition + cellHeight
                ourCellHeight = 86 + 15
            }
        }
        
        let layoutAttribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        layoutAttribute.frame = CGRect(x: xPosition, y: yPosition, width: width, height: ourCellHeight)
        return layoutAttribute
    }
    
    // Asks the layout object if the new bounds require a layout update.
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
}
