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
    var delegate: ListsViewLayoutDelegate?

    var storedLayouts: [UICollectionViewLayoutAttributes]?
    
    var contentHeight: CGFloat = 0.0
    
    override var collectionViewContentSize : CGSize {
        let contentWidth: CGFloat = self.collectionView!.bounds.size.width
        return CGSize(width: contentWidth, height: contentHeight + 56)
    }
    
    // Returns the layout attributes for all of the cells and views in the specified rectangle.
    // I would say that A little math here wouldn't hurt.
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        if storedLayouts == nil {
            initialLayoutAttributes()
        }
        return storedLayouts!
    }
    
    func initialLayoutAttributes() {
        
        storedLayouts = [UICollectionViewLayoutAttributes]()
        var attributes = [UICollectionViewLayoutAttributes]()
        
        if let delegate = delegate {
            let total = delegate.numberofItems()
            
            var lastY: CGFloat = 0.0
            var lastHeight: CGFloat = 44.0
            
            var index = 0
            while index < total {
                
                // make a little index
                let indexPath = IndexPath(row: index, section: 0)
                
                // Get the Layout Attributes for a thing.
                let width: CGFloat = self.collectionView!.bounds.size.width
                var yPosition: CGFloat = 0
                
                let layoutAttribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                
                // get the height of the Cell!!
                var tempCellHeight = cellHeight
                tempCellHeight = estimateHeightForText(text: delegate.textFor(indexPath: indexPath)).height + 20
                
                // get the yPosition of the Cell
                if indexPath.row == 0 {
                    yPosition = lastY
                } else {
                    yPosition = lastY + lastHeight
                }
                
                // make the actual attributes
                layoutAttribute.frame = CGRect(x: 0, y: yPosition, width: width, height: tempCellHeight)
                lastY = yPosition
                lastHeight = tempCellHeight
                attributes.append(layoutAttribute)
                contentHeight = lastY + lastHeight
                index = index + 1
            }
            storedLayouts = attributes
        }
        
    }
    
    // Returns the layout attributes for the item at the specified index path.
    // This will probably have a little math too.
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        if storedLayouts == nil {
            initialLayoutAttributes()
        }
        return storedLayouts?[indexPath.row]
//
//        let cellPadding: CGFloat = 0
//        let width: CGFloat = self.collectionView!.bounds.size.width
//
//        var yPosition: CGFloat = 0
//        let upperPadding: CGFloat = 0
//
//        // for the regular cells
//
////        print("\(indexPath.row + 1): yPosition: \(yPosition), height: \(cellHeight)")
//
//        let layoutAttribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
//
//        // get the height of the Cell!!
//        var tempCellHeight = cellHeight
//        if let delegate = delegate {
//            tempCellHeight = estimateHeightForText(text: delegate.textFor(indexPath: indexPath)).height + 20
//        }
//        if indexPath.row == 0 {
//            yPosition = upperPadding
//        } else {
//            let upperAttributes = self.layoutAttributesForItem(at: IndexPath(row: (indexPath.row - 1), section: 0))
//            yPosition = (upperAttributes?.bounds.origin.y)! + (upperAttributes?.bounds.height)!
//        }
//
//        layoutAttribute.frame = CGRect(x: 0, y: yPosition, width: width, height: tempCellHeight)
//        return layoutAttribute
    }
    
    override func initialLayoutAttributesForAppearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return layoutAttributesForItem(at: itemIndexPath)
    }
    
    override func finalLayoutAttributesForDisappearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return layoutAttributesForItem(at: itemIndexPath)
    }
    
    // Asks the layout object if the new bounds require a layout update.
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return false
    }
    
    private func estimateHeightForText(text: String) -> CGRect {
        let height: CGFloat = 20000.0
        let width = collectionViewContentSize.width - 54.0 // 54 is an arbitrary number, kinda,
        // it's the base width that we lose when we remove the space for the checkboxes or unfinished
        // tasks box
        
        let size = CGSize(width: width, height: height)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let attributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.light)]
        
        return NSString(string: text).boundingRect(with: size, options: options, attributes: attributes, context: nil)
    }
    
}

protocol ListViewsLayoutDelegateProtocol {
    
    func textFor(indexPath: IndexPath) -> String
    func numberofItems() -> Int
}

typealias ListsViewLayoutDelegate = ListViewsLayoutDelegateProtocol

