//
//  FlickrLayout.swift
//  Layout App
//
//  Created by Jack Ily on 24/06/2019.
//  Copyright © 2019 Jack Ily. All rights reserved.
//

import UIKit

class FlickrLayout: FlowLayout {
    
    fileprivate var numberOfCellInSection = 4
    
    override func calculateCellFrame() {
        guard cache.isEmpty == true, let collectionView = collectionView else { return }
        let collectionViewWidth = collectionView.frame.size.width
        let collectionViewHeight = collectionView.frame.size.height
        
        contentSize.width = collectionViewWidth
        
        let smallColumnWidth = (collectionViewWidth - contentPadding.horizontal*2 - cellPadding)/2.0
        let largeColumnWidth = collectionViewWidth - contentPadding.horizontal*2
        
        let smallColumnHeight = (collectionViewHeight - contentPadding.vertical*2)/5.0
        let largeColumnHeight = (collectionViewHeight - contentPadding.vertical*2)/4.0
        
        var xOffset = contentPadding.horizontal
        var yOffset = contentPadding.vertical
        
        let sectionsCount = collectionView.numberOfSections
        for section in 0..<sectionsCount {
            let itemsCount = collectionView.numberOfItems(inSection: section)
            for item in 0..<itemsCount {
                let indexPath = IndexPath(item: item, section: section)
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                let item = indexPath.item
                
                if item % numberOfCellInSection == 0 {
                    let frame = CGRect(x: xOffset,
                                       y: yOffset,
                                       width: smallColumnWidth,
                                       height: smallColumnHeight)
                    attributes.frame = frame
                    yOffset = (item+1 == itemsCount) ? yOffset + smallColumnHeight : yOffset
                    
                } else if item % numberOfCellInSection == 1 {
                    yOffset += cellPadding
                    let bottomFrame = CGRect(x: xOffset,
                                             y: yOffset + smallColumnHeight,
                                             width: smallColumnWidth,
                                             height: smallColumnHeight)
                    let rightFrame = CGRect(x: xOffset + cellPadding + smallColumnWidth,
                                            y: yOffset - cellPadding,
                                            width: smallColumnWidth,
                                            height: smallColumnHeight)
                    attributes.frame = (item+1 == itemsCount) ? rightFrame : bottomFrame
                    yOffset = (item+1 == itemsCount) ? yOffset + smallColumnHeight : yOffset
                    xOffset += (smallColumnWidth + cellPadding)
                    
                } else if item % numberOfCellInSection == 2 {
                    yOffset -= cellPadding
                    let frame = CGRect(x: xOffset,
                                       y: yOffset,
                                       width: smallColumnWidth,
                                       height: smallColumnHeight*2.0 + cellPadding)
                    attributes.frame = frame
                    yOffset += (smallColumnHeight + cellPadding)*2.0
                    xOffset -= (smallColumnWidth + cellPadding)
                    
                } else if item % numberOfCellInSection == 3 {
                    let largeFrame = CGRect(x: xOffset,
                                            y: yOffset,
                                            width: largeColumnWidth,
                                            height: largeColumnHeight)
                    attributes.frame = largeFrame
                    yOffset += (largeColumnHeight + cellPadding)
                }
                
                cache.append(attributes)
            }
        }
        
        contentSize.height = yOffset + contentPadding.vertical
    }
}
