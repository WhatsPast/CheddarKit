//
//  ListsViewLayout.swift
//  CheddarKit
//
//  Created by Karl Weber on 1/2/18.
//  Copyright © 2018 Karl Weber. All rights reserved.
//

import UIKit

class ListsViewLayout: UICollectionViewLayout {
    
    let cellHeight: CGFloat = 44.0

    var storedLayouts: [UICollectionViewLayoutAttributes]?
    
    override var collectionViewContentSize : CGSize {
        let contentWidth: CGFloat = self.collectionView!.bounds.size.width
        let total = CGFloat((collectionView!.dataSource?.collectionView(collectionView!, numberOfItemsInSection: 0))!)
        let contentHeight: CGFloat = (cellHeight * total) + 44
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    // Returns the layout attributes for all of the cells and views in the specified rectangle.
    // I would say that A little math here wouldn't hurt.
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var myRect = rect
        // always make the rect bigger.
        myRect = CGRect(x: rect.origin.x, y: 0, width: rect.width, height: rect.height)
        
        var attributes = [UICollectionViewLayoutAttributes]()
        
        if let storedLayouts = storedLayouts {
            attributes = storedLayouts
        } else {
//            print("Calculate all the possible layout stuff.")
            // iterate through every possible indexPath/cell in the whole dang thing
            // if it falls within the rect add it.
            for item in 0..<(collectionView!.numberOfItems(inSection: 0)) {
                let att = self.layoutAttributesForItem(at: IndexPath(item:item, section: 0))!
//                if att.frame.intersects(myRect) {
                    attributes.append(att)
//                }
            }
            storedLayouts = attributes
        }
        
        return attributes
    }
    
    // Returns the layout attributes for the item at the specified index path.
    // This will probably have a little math too.
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let cellPadding: CGFloat = 0
        let width: CGFloat = self.collectionView!.bounds.size.width
        
        var yPosition: CGFloat = 0
        let upperPadding: CGFloat = 0
        
        // for the regular cells
        yPosition = CGFloat((indexPath as NSIndexPath).item) * (cellHeight + cellPadding) + upperPadding
//        print("\(indexPath.row + 1): yPosition: \(yPosition), height: \(cellHeight)")
        
        let layoutAttribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        layoutAttribute.frame = CGRect(x: 0, y: yPosition, width: width, height: cellHeight)
        return layoutAttribute
    }
    
    // Asks the layout object if the new bounds require a layout update.
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
}
