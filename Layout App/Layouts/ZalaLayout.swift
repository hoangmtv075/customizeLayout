//
//  ZalaLayout.swift
//  Layout App
//
//  Created by Jack Ily on 24/06/2019.
//  Copyright © 2019 Jack Ily. All rights reserved.
//

import UIKit

class ZalaLayout: FlowLayout {
    
    fileprivate var numberOfItemsInSection = 6
    
    override func calculateCellFrame() {
        guard cache.isEmpty == true, let collectionView = collectionView else { return }
        let collectionViewWidth = collectionView.frame.size.width
        contentSize.width = collectionViewWidth
        
        let columnWidth = (collectionViewWidth - ((contentPadding.horizontal + cellPadding)*2.0))/3.0
        var xOffset = contentPadding.horizontal
        var yOffset = contentPadding.vertical
        
        let sectionsCount = collectionView.numberOfSections
        for section in 0..<sectionsCount {
            let itemsCount = collectionView.numberOfItems(inSection: section)
            for item in 0..<itemsCount {
                let indexPath = IndexPath(item: item, section: section)
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                let item = indexPath.item
                
                if item % numberOfItemsInSection == 0 {
                    let frame = CGRect(x: xOffset,
                                       y: yOffset,
                                       width: columnWidth,
                                       height: columnWidth)
                    attributes.frame = frame
                    yOffset = (item+1 == itemsCount) ? yOffset + columnWidth : yOffset
                    
                } else if item % numberOfItemsInSection == 1 {
                    let bottomFrame = CGRect(x: xOffset,
                                             y: yOffset + cellPadding + columnWidth,
                                             width: columnWidth,
                                             height: columnWidth)
                    let rightFrame = CGRect(x: xOffset + cellPadding + columnWidth,
                                            y: yOffset,
                                            width: columnWidth,
                                            height: columnWidth)
                    attributes.frame = (item+1 == itemsCount) ? rightFrame : bottomFrame
                    yOffset = (item+1 == itemsCount) ? yOffset + columnWidth : yOffset
                    xOffset += (columnWidth + cellPadding)
                    
                } else if item % numberOfItemsInSection == 2 {
                    let frame = CGRect(x: xOffset,
                                       y: yOffset,
                                       width: columnWidth,
                                       height: columnWidth*2.0 + cellPadding)
                    attributes.frame = frame
                    yOffset = (item+1 == itemsCount) ? yOffset + columnWidth*2.0 : yOffset
                    xOffset += (columnWidth + cellPadding)
                    
                } else if item % numberOfItemsInSection == 3 {
                    let frame = CGRect(x: xOffset,
                                       y: yOffset,
                                       width: columnWidth,
                                       height: columnWidth)
                    attributes.frame = frame
                    yOffset = (item+1 == itemsCount) ? yOffset + columnWidth*2 : yOffset
                    
                } else if item % numberOfItemsInSection == 4 {
                    yOffset += (columnWidth + cellPadding)
                    let frame = CGRect(x: xOffset,
                                       y: yOffset,
                                       width: columnWidth,
                                       height: columnWidth)
                    attributes.frame = frame
                    yOffset += (columnWidth + cellPadding)
                    xOffset = contentPadding.horizontal
                    
                } else if item % numberOfItemsInSection == 5 {
                    let frame = CGRect(x: xOffset,
                                       y: yOffset,
                                       width: columnWidth*3.0 + contentPadding.horizontal*2.0,
                                       height: columnWidth)
                    attributes.frame = frame
                    yOffset += (columnWidth + cellPadding)
                }
                
                cache.append(attributes)
            }
        }
        
        contentSize.height = yOffset + contentPadding.vertical
    }
}
