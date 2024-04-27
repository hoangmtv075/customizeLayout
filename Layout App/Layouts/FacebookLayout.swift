//
//  FacebookLayout.swift
//  Layout App
//
//  Created by Jack Ily on 24/06/2019.
//  Copyright © 2019 Jack Ily. All rights reserved.
//

import UIKit

class FacebookLayout: FlowLayout {
    
    fileprivate var numberOfItemsInSection = 5
    
    override func calculateCellFrame() {
        guard cache.isEmpty == true, let collectionView = collectionView else { return }
        let collectionViewWidth = collectionView.frame.size.width
        contentSize.width = collectionViewWidth
        
        let largeColumnWidth = (collectionViewWidth - contentPadding.horizontal*2.0 - cellPadding)/2.0
        let smallColumnWidth = (collectionViewWidth - (contentPadding.horizontal + cellPadding)*2.0)/3.0
        
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
                                       width: largeColumnWidth,
                                       height: largeColumnWidth)
                    attributes.frame = frame
                    yOffset = (item+1 == itemsCount) ? yOffset + largeColumnWidth : yOffset
                    xOffset += (cellPadding + largeColumnWidth)
                    
                } else if item % numberOfItemsInSection == 1 {
                    let frame = CGRect(x: xOffset,
                                       y: yOffset,
                                       width: largeColumnWidth,
                                       height: largeColumnWidth)
                    attributes.frame = frame
                    yOffset += (largeColumnWidth + cellPadding)
                    xOffset = contentPadding.horizontal
                    
                } else if item % numberOfItemsInSection == 2 {
                    let frame = CGRect(x: xOffset,
                                       y: yOffset,
                                       width: smallColumnWidth,
                                       height: smallColumnWidth)
                    attributes.frame = frame
                    yOffset = (item+1 == itemsCount) ? yOffset + smallColumnWidth : yOffset
                    xOffset += (smallColumnWidth + cellPadding)
                    
                } else if item % numberOfItemsInSection == 3 {
                    let frame = CGRect(x: xOffset,
                                       y: yOffset,
                                       width: smallColumnWidth,
                                       height: smallColumnWidth)
                    attributes.frame = frame
                    yOffset = (item+1 == itemsCount) ? yOffset + smallColumnWidth : yOffset
                    xOffset += (smallColumnWidth + cellPadding)
                    
                } else if item % numberOfItemsInSection == 4 {
                    let frame = CGRect(x: xOffset,
                                       y: yOffset,
                                       width: smallColumnWidth,
                                       height: smallColumnWidth)
                    attributes.frame = frame
                    yOffset += (cellPadding + smallColumnWidth)
                    xOffset = contentPadding.horizontal
                }
                
                cache.append(attributes)
            }
        }
        
        contentSize.height = yOffset + contentPadding.vertical
    }
}
