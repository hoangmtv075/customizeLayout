//
//  PinterestLayout.swift
//  Layout App
//
//  Created by Jack Ily on 22/06/2019.
//  Copyright © 2019 Jack Ily. All rights reserved.
//

import UIKit

protocol PinterestLayoutDelegate: AnyObject {
    
    func collectionView(heightForPhotoAt indexPath: IndexPath) -> CGFloat
}

public class PinterestLayout: FlowLayout {
    
    weak var delegate: PinterestLayoutDelegate!
    
    fileprivate var numberOfColumns = 2
    
    override public func calculateCellFrame() {
        guard cache.isEmpty == true, let collectionView = collectionView else { return }
        let collectionViewWidth = collectionView.frame.size.width
        let inset = collectionView.contentInset
        let contentWidth = collectionViewWidth - (inset.left + inset.right)
        contentSize.width = contentWidth
        
        let columnWidth = contentWidth/CGFloat(numberOfColumns)
        
        var xOffset = [CGFloat]()
        for column in 0..<numberOfColumns {
            xOffset.append(CGFloat(column) * columnWidth)
        }
        
        var column = 0
        var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)
        
        let sectionsCount = collectionView.numberOfSections
        for section in 0..<sectionsCount {
            let itemsCount = collectionView.numberOfItems(inSection: section)
            for item in 0..<itemsCount {
                let indexPath = IndexPath(item: item, section: section)
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                let photoHeight = delegate.collectionView(heightForPhotoAt: indexPath)
                let height = cellPadding*2 + photoHeight/3.0
                let frame = CGRect(x: xOffset[column],
                                   y: yOffset[column],
                                   width: columnWidth,
                                   height: height)
                let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
                attributes.frame = insetFrame
                cache.append(attributes)
                
                contentSize.height = max(contentSize.height, frame.maxY)
                yOffset[column] = yOffset[column] + height
                column = column < (numberOfColumns - 1) ? (column + 1) : 0
            }
        }
    }
}
