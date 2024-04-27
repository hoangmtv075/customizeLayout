//
//  KiwiLayout.swift
//  Layout App
//
//  Created by Jack Ily on 24/06/2019.
//  Copyright © 2019 Jack Ily. All rights reserved.
//

import UIKit

class KiwiLayout: FlowLayout {
    
    fileprivate var numberOfItemsInSection = 4
    
    override func calculateCellFrame() {
        guard cache.isEmpty == true, let collectionView = collectionView else { return }
        let collectionViewWidth = collectionView.frame.size.width
        contentSize.width = collectionViewWidth
        
        let largeColumnWidth = collectionViewWidth - contentPadding.horizontal*2
        let smallColumnWidth = (collectionViewWidth - contentPadding.horizontal*2.0 - cellPadding)/2.0
        
        let xOffset = contentPadding.horizontal
        var yOffset = contentPadding.vertical
        
        let sectionsCount = collectionView.numberOfSections
        for section in 0..<sectionsCount {
            let itemsCount = collectionView.numberOfItems(inSection: section)
            for item in 0..<itemsCount {
                let indexPath = IndexPath(item: item, section: section)
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                let item = indexPath.item
                
                if item % numberOfItemsInSection == 0 {
                    let largeFrame = CGRect(x: xOffset,
                                            y: yOffset,
                                            width: largeColumnWidth,
                                            height: largeColumnWidth)
                    let leftFrame = CGRect(x: xOffset + 20.0,
                                           y: yOffset,
                                           width: smallColumnWidth,
                                           height: smallColumnWidth)
                    let centralFrame = CGRect(x: xOffset + (cellPadding + smallColumnWidth)/2.0,
                                              y: yOffset,
                                              width: smallColumnWidth,
                                              height: smallColumnWidth)
                    
                    if item + 1 == itemsCount {
                        attributes.frame = largeFrame
                        
                    } else if item + 1 == itemsCount - 1 || item + 1 == itemsCount - 3 {
                        attributes.frame = leftFrame
                        
                    } else if item + 1 == itemsCount - 2 {
                        attributes.frame = centralFrame   
                    }
                    
                } else if item % numberOfItemsInSection == 1 {
                    let rightFrame = CGRect(x: xOffset + cellPadding + smallColumnWidth - 20.0,
                                            y: yOffset,
                                            width: smallColumnWidth,
                                            height: smallColumnWidth)
                    let bottomFrame = CGRect(x: xOffset + 20.0,
                                             y: yOffset + cellPadding + smallColumnWidth - 30.0,
                                             width: smallColumnWidth,
                                             height: smallColumnWidth)
                    
                    attributes.frame = (item+1 == itemsCount-1) ? bottomFrame : rightFrame
                    yOffset += (smallColumnWidth + cellPadding)
                    
                } else if item % numberOfItemsInSection == 2 {
                    let rightFrame = CGRect(x: xOffset + cellPadding + smallColumnWidth - 30.0,
                                            y: yOffset - 20.0,
                                            width: smallColumnWidth,
                                            height: smallColumnWidth)
                    let leftFrame = CGRect(x: xOffset + 20.0,
                                           y: yOffset - 30.0,
                                           width: smallColumnWidth,
                                           height: smallColumnWidth)
                    attributes.frame = (item+1 == itemsCount) ? rightFrame : leftFrame
                    
                } else if item % numberOfItemsInSection == 3 {
                    let frame = CGRect(x: xOffset + cellPadding + smallColumnWidth - 20.0,
                                       y: yOffset - 30.0,
                                       width: smallColumnWidth,
                                       height: smallColumnWidth)
                    attributes.frame = frame
                }
                
                cache.append(attributes)
            }
        }
        
        contentSize.height = yOffset + contentPadding.vertical
    }
}
