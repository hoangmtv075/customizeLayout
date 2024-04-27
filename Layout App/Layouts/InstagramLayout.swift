//
//  InstagramLayout.swift
//  Layout App
//
//  Created by Jack Ily on 23/06/2019.
//  Copyright © 2019 Jack Ily. All rights reserved.
//

import UIKit

public class InstagramLayout: FlowLayout {
    
    fileprivate var numberOfSections = 4
    fileprivate var numberOfRows = 2
    fileprivate var numberOfColumns = 3
    
    public override func calculateCellFrame() {
        guard cache.isEmpty == true, let collectionView = collectionView else { return }
        let collectionViewWidth = collectionView.frame.size.width
        contentSize.width = collectionViewWidth
        
        let columnWidth = (collectionViewWidth - contentPadding.horizontal*2 - cellPadding*2)/CGFloat(numberOfColumns)
        
        var xOffset = contentPadding.horizontal
        var yOffset = contentPadding.vertical
        
        var kSection = 0
        var rowCount = 0
        
        let sectionsCount = collectionView.numberOfSections
        for section in 0..<sectionsCount {
            let itemsCount = collectionView.numberOfItems(inSection: section)
            for item in 0..<itemsCount {
                let indexPath = IndexPath(item: item, section: section)
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                
                if kSection % numberOfSections == 0 {
                    calculateRightFrame(attributes,
                                        collectionView, indexPath,
                                        &xOffset,
                                        &yOffset,
                                        &kSection,
                                        section,
                                        columnWidth)
                    
                } else if kSection % numberOfSections == 1 || kSection % numberOfSections == 3 {
                    calculateDefaultFrame(attributes,
                                          collectionView, indexPath,
                                          &xOffset,
                                          &yOffset,
                                          &kSection,
                                          section,
                                          columnWidth,
                                          &rowCount)
                    
                } else if kSection % numberOfSections == 2 {
                    calculateLeftFrame(attributes,
                                       collectionView, indexPath,
                                       &xOffset,
                                       &yOffset,
                                       &kSection,
                                       section,
                                       columnWidth)
                }
                
                cache.append(attributes)
            }
        }
        
        contentSize.height = yOffset + contentPadding.vertical
    }
    
    private func calculateRightFrame(_ attributes: UICollectionViewLayoutAttributes,
                                     _ collectionView: UICollectionView,
                                     _ indexPath: IndexPath,
                                     _ xOffset: inout CGFloat,
                                     _ yOffset: inout CGFloat,
                                     _ kSection: inout Int,
                                     _ section: Int,
                                     _ columnWidth: CGFloat) {
        let itemsCount = collectionView.numberOfItems(inSection: section)
        let item = indexPath.item
        
        if item % numberOfColumns == 0 {
            let frame = CGRect(x: xOffset,
                               y: yOffset,
                               width: columnWidth,
                               height: columnWidth)
            attributes.frame = frame
            yOffset = (item+1 == itemsCount) ? yOffset + columnWidth : yOffset
            
        } else if item % numberOfColumns == 1 {
            yOffset += cellPadding
            let bottomFrame = CGRect(x: xOffset,
                                     y: yOffset + columnWidth,
                                     width: columnWidth,
                                     height: columnWidth)
            let rightFrame = CGRect(x: xOffset + cellPadding + columnWidth,
                                    y: yOffset - cellPadding,
                                    width: columnWidth,
                                    height: columnWidth)
            attributes.frame = (item+1 == itemsCount) ? rightFrame : bottomFrame
            yOffset = (item+1 == itemsCount) ? yOffset + columnWidth : yOffset
            xOffset += (columnWidth + cellPadding)
            
        } else if item % numberOfColumns == 2 {
            yOffset -= cellPadding
            let width = columnWidth*2 + cellPadding
            let frame = CGRect(x: xOffset,
                               y: yOffset,
                               width: width,
                               height: width)
            attributes.frame = frame
            yOffset += (width + cellPadding)
            xOffset = contentPadding.horizontal
            kSection += 1
        }
    }
    
    private func calculateDefaultFrame(_ attributes: UICollectionViewLayoutAttributes,
                                       _ collectionView: UICollectionView,
                                       _ indexPath: IndexPath,
                                       _ xOffset: inout CGFloat,
                                       _ yOffset: inout CGFloat,
                                       _ kSection: inout Int,
                                       _ section: Int,
                                       _ columnWidth: CGFloat,
                                       _ rowCount: inout Int) {
        let itemsCount = collectionView.numberOfItems(inSection: section)
        let item = indexPath.item
        
        xOffset = CGFloat(item % numberOfColumns) * (columnWidth + cellPadding) + contentPadding.horizontal
        let frame = CGRect(x: xOffset,
                           y: yOffset,
                           width: columnWidth,
                           height: columnWidth)
        attributes.frame = frame
        
        if item % numberOfColumns == 2 {
            xOffset = contentPadding.horizontal
            yOffset += (columnWidth + cellPadding)
            rowCount += 1
        }
        
        if rowCount == numberOfRows {
            rowCount = 0
            kSection += 1
        }
        
        yOffset = (item+1 == itemsCount && item % numberOfColumns != 2) ? yOffset + columnWidth : yOffset
    }
    
    private func calculateLeftFrame(_ attributes: UICollectionViewLayoutAttributes,
                                    _ collectionView: UICollectionView,
                                    _ indexPath: IndexPath,
                                    _ xOffset: inout CGFloat,
                                    _ yOffset: inout CGFloat,
                                    _ kSection: inout Int,
                                    _ section: Int,
                                    _ columnWidth: CGFloat) {
        let itemsCount = collectionView.numberOfItems(inSection: section)
        let item = indexPath.item
        
        if item % numberOfColumns == 0 {
            let width = columnWidth*2 + cellPadding
            let largeFrame = CGRect(x: xOffset,
                                    y: yOffset,
                                    width: width,
                                    height: width)
            let smallFrame = CGRect(x: xOffset,
                                    y: yOffset,
                                    width: columnWidth,
                                    height: columnWidth)
            attributes.frame = (item+1 == itemsCount || item+1 == itemsCount-1) ? smallFrame : largeFrame
            yOffset = (item+1 == itemsCount) ? yOffset + columnWidth : yOffset
            xOffset += (cellPadding + columnWidth)*2.0
            
        } else if item % numberOfColumns == 1 {
            let rightFrame = CGRect(x: xOffset,
                                    y: yOffset,
                                    width: columnWidth,
                                    height: columnWidth)
            let centralFrame = CGRect(x: xOffset - columnWidth - cellPadding,
                                      y: yOffset,
                                      width: columnWidth,
                                      height: columnWidth)
            attributes.frame = (item+1 == itemsCount) ? centralFrame : rightFrame
            yOffset += (columnWidth + cellPadding)
            
        } else if item % numberOfColumns == 2 {
            let frame = CGRect(x: xOffset,
                               y: yOffset,
                               width: columnWidth,
                               height: columnWidth)
            attributes.frame = frame
            yOffset += (columnWidth + cellPadding)
            kSection += 1
        }
    }
}
