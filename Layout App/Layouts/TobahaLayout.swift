//
//  TobahaLayout.swift
//  Layout App
//
//  Created by Jack Ily on 25/06/2019.
//  Copyright © 2019 Jack Ily. All rights reserved.
//

import UIKit

class TobahaLayout: FlowLayout {
    
    fileprivate var numberOfItemsInSection = 7
    
    override func calculateCellFrame() {
        guard cache.isEmpty == true, let collectionView = collectionView else { return }
        let collectionViewWidth = collectionView.frame.size.width
        contentSize.width = collectionViewWidth
        
        let smallWidth = (collectionViewWidth - contentPadding.horizontal*2 - cellPadding*3)/4.0
        let largeWidth = (collectionViewWidth - contentPadding.horizontal*2 - cellPadding)/2.0
        let mediumWidth = smallWidth*2 + cellPadding
        
        let longWidth = collectionViewWidth - contentPadding.horizontal*2
        let averageWidth = (collectionViewWidth - (contentPadding.horizontal + cellPadding)*2)/3.0
        
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
                    let mediumFrame = CGRect(x: xOffset,
                                             y: yOffset,
                                             width: largeWidth,
                                             height: largeWidth)
                    let longFrame = CGRect(x: xOffset,
                                           y: yOffset,
                                           width: longWidth,
                                           height: smallWidth)
                    attributes.frame = (item+1 == itemsCount) ? longFrame : mediumFrame
                    yOffset = (item+1 == itemsCount) ? yOffset + smallWidth : yOffset
                    xOffset = (item+1 == itemsCount) ? xOffset : xOffset + largeWidth + cellPadding
                    
                } else if item % numberOfItemsInSection == 1 {
                    let frame = CGRect(x: xOffset,
                                       y: yOffset,
                                       width: largeWidth,
                                       height: largeWidth)
                    attributes.frame = frame
                    yOffset += (largeWidth + cellPadding)
                    xOffset = contentPadding.horizontal
                    
                } else if item % numberOfItemsInSection == 2 {
                    let shortFrame = CGRect(x: xOffset,
                                            y: yOffset,
                                            width: smallWidth,
                                            height: smallWidth)
                    let longFrame = CGRect(x: xOffset,
                                           y: yOffset,
                                           width: longWidth,
                                           height: smallWidth)
                    let averageFrame = CGRect(x: xOffset,
                                              y: yOffset,
                                              width: averageWidth,
                                              height: smallWidth)
                    let haftFrame = CGRect(x: xOffset,
                                           y: yOffset,
                                           width: largeWidth,
                                           height: smallWidth)
                    
                    if item + 1 == itemsCount {
                        attributes.frame = longFrame
                        
                    } else if item + 1 == itemsCount - 1 {
                        attributes.frame = haftFrame
                        
                    } else if item + 1 == itemsCount - 2 {
                        attributes.frame = averageFrame
                        
                    } else {
                        attributes.frame = shortFrame
                    }
                    
                    yOffset = (item+1 == itemsCount) ? yOffset + smallWidth : yOffset
                    
                } else if item % numberOfItemsInSection == 3 {
                    let haftFrame = CGRect(x: xOffset + cellPadding + largeWidth,
                                           y: yOffset,
                                           width: largeWidth,
                                           height: smallWidth)
                    let averageFrame = CGRect(x: xOffset + averageWidth + cellPadding,
                                              y: yOffset,
                                              width: averageWidth,
                                              height: smallWidth)
                    let bottomFrame = CGRect(x: xOffset,
                                             y: yOffset + cellPadding + smallWidth,
                                             width: smallWidth,
                                             height: smallWidth)
                    let smallFrame = CGRect(x: xOffset + smallWidth + cellPadding,
                                            y: yOffset,
                                            width: smallWidth,
                                            height: smallWidth)
                    
                    if item + 1 == itemsCount {
                        attributes.frame = haftFrame
                        
                    } else if item + 1 == itemsCount - 1 {
                        attributes.frame = averageFrame
                        
                    } else if item + 1 == itemsCount - 2 {
                        attributes.frame = smallFrame
                        
                    } else {
                        attributes.frame = bottomFrame
                    }
                    
                    yOffset = (item+1 == itemsCount) ? yOffset + smallWidth : yOffset
                    
                } else if item % numberOfItemsInSection == 4 {
                    let averageFrame = CGRect(x: xOffset + (averageWidth + cellPadding)*2,
                                              y: yOffset,
                                              width: averageWidth,
                                              height: smallWidth)
                    let smallFrame = CGRect(x: xOffset + (cellPadding + smallWidth)*2,
                                            y: yOffset,
                                            width: smallWidth,
                                            height: smallWidth)
                    let largeFrame = CGRect(x: xOffset + smallWidth + cellPadding,
                                            y: yOffset,
                                            width: mediumWidth,
                                            height: mediumWidth)
                    
                    if item + 1 == itemsCount {
                        attributes.frame = averageFrame
                        
                    } else if item + 1 == itemsCount - 1 {
                        attributes.frame = smallFrame
                        
                    } else {
                        attributes.frame = largeFrame
                    }
                    
                    yOffset = (item+1 == itemsCount) ? yOffset + smallWidth : yOffset
                    xOffset += (smallWidth + cellPadding)*3.0
                    
                } else if item % numberOfItemsInSection == 5 {
                    let frame = CGRect(x: xOffset,
                                       y: yOffset,
                                       width: smallWidth,
                                       height: smallWidth)
                    attributes.frame = frame
                    yOffset += (smallWidth + cellPadding)
                    
                } else if item % numberOfItemsInSection == 6 {
                    let frame = CGRect(x: xOffset,
                                       y: yOffset,
                                       width: smallWidth,
                                       height: smallWidth)
                    attributes.frame = frame
                    yOffset += (smallWidth + cellPadding)
                    xOffset = contentPadding.horizontal
                }
                
                cache.append(attributes)
            }
        }
        
        contentSize.height = yOffset + contentPadding.vertical
    }
}
