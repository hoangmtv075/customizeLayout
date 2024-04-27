//
//  FlipboardLayout.swift
//  Layout App
//
//  Created by Jack Ily on 24/06/2019.
//  Copyright © 2019 Jack Ily. All rights reserved.
//

import UIKit

class FlipboardLayout: FlowLayout {
    
    fileprivate var numberOfItemsInSection = 8
    fileprivate var numberOfColumns = 3
    
    override func calculateCellFrame() {
        guard cache.isEmpty == true, let collectionView = collectionView else { return }
        let collectionViewWidth = collectionView.frame.size.width
        contentSize.width = collectionViewWidth
        
        let columnWidth = (collectionViewWidth - (contentPadding.horizontal + cellPadding)*2)/CGFloat(numberOfColumns)
        
        var xOffset = contentPadding.horizontal
        var yOffset = contentPadding.vertical
        
        let sectionsCount = collectionView.numberOfSections
        for section in 0..<sectionsCount {
            let itemsCount = collectionView.numberOfItems(inSection: section)
            for item in 0..<itemsCount {
                let indexPath = IndexPath(item: item, section: section)
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                
                calculateFrame(attributes,
                               collectionView,
                               indexPath,
                               &xOffset,
                               &yOffset,
                               section,
                               columnWidth)
                
                cache.append(attributes)
            }
        }
        
        contentSize.height = yOffset + contentPadding.vertical
    }
    
    private func calculateFrame(_ attributes: UICollectionViewLayoutAttributes,
                                _ collectionView: UICollectionView,
                                _ indexPath: IndexPath,
                                _ xOffset: inout CGFloat,
                                _ yOffset: inout CGFloat,
                                _ section: Int,
                                _ columnWidth: CGFloat) {
        let itemsCount = collectionView.numberOfItems(inSection: section)
        let item = indexPath.item
        
        if item % numberOfItemsInSection == 0 {
            let largeFrame = CGRect(x: xOffset,
                                    y: yOffset,
                                    width: columnWidth*2 + cellPadding,
                                    height: columnWidth)
            let smallFrame = CGRect(x: xOffset,
                                    y: yOffset,
                                    width: columnWidth,
                                    height: columnWidth)
            attributes.frame = (item+1 == itemsCount) ? smallFrame : largeFrame
            yOffset = (item+1 == itemsCount) ? yOffset + columnWidth : yOffset
            xOffset += (columnWidth + cellPadding)
            
        } else if item % numberOfItemsInSection == 1 {
            let rightFrame = CGRect(x: xOffset + columnWidth + cellPadding,
                                    y: yOffset,
                                    width: columnWidth,
                                    height: columnWidth)
            attributes.frame = rightFrame
            yOffset = (item+1 == itemsCount) ? yOffset + columnWidth : yOffset
            xOffset = contentPadding.horizontal
            
            
        } else if item % numberOfItemsInSection == 2 {
            yOffset += (columnWidth + cellPadding)
            let frame = CGRect(x: xOffset,
                               y: yOffset,
                               width: columnWidth,
                               height: columnWidth)
            attributes.frame = frame
            yOffset = (item+1 == itemsCount) ? yOffset + columnWidth : yOffset
            xOffset += (columnWidth + cellPadding)
            
        } else if item % numberOfItemsInSection == 3 {
            let frame = CGRect(x: xOffset,
                               y: yOffset,
                               width: columnWidth,
                               height: columnWidth)
            attributes.frame = frame
            yOffset = (item+1 == itemsCount) ? yOffset + columnWidth : yOffset
            xOffset += (columnWidth + cellPadding)
            
        } else if item % numberOfItemsInSection == 4 {
            let frame = CGRect(x: xOffset,
                               y: yOffset,
                               width: columnWidth,
                               height: columnWidth)
            attributes.frame = frame
            xOffset = contentPadding.horizontal
            yOffset += (columnWidth + cellPadding)
            
        } else if item % numberOfItemsInSection == 5 {
            let frame = CGRect(x: xOffset,
                               y: yOffset,
                               width: columnWidth,
                               height: columnWidth)
            attributes.frame = frame
            yOffset = (item+1 == itemsCount) ? yOffset + columnWidth : yOffset
            xOffset += (columnWidth + cellPadding)
            
        } else if item % numberOfItemsInSection == 6 {
            let frame = CGRect(x: xOffset,
                               y: yOffset,
                               width: columnWidth,
                               height: columnWidth)
            attributes.frame = frame
            yOffset = (item+1 == itemsCount) ? yOffset + columnWidth : yOffset
            xOffset += (columnWidth + cellPadding)
            
        } else if item % numberOfItemsInSection == 7 {
            let frame = CGRect(x: xOffset,
                               y: yOffset,
                               width: columnWidth,
                               height: columnWidth)
            attributes.frame = frame
            xOffset = contentPadding.horizontal
            yOffset += (columnWidth + cellPadding)
        }
    }
}
