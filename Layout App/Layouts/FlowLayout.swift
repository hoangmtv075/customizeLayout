//
//  FlowLayout.swift
//  Layout App
//
//  Created by Jack Ily on 23/06/2019.
//  Copyright © 2019 Jack Ily. All rights reserved.
//

import UIKit

public struct ItemsPadding {
    
    public let horizontal: CGFloat
    public let vertical: CGFloat
    
    public init(horizontal: CGFloat = 0.0, vertical: CGFloat = 0.0) {
        self.horizontal = horizontal
        self.vertical = vertical
    }
    
    static var zero: ItemsPadding {
        return ItemsPadding()
    }
}

public class FlowLayout: UICollectionViewFlowLayout {
    
    public var contentPadding: ItemsPadding = .zero
    public var cellPadding: CGFloat = 0.0
    
    public var cache = [UICollectionViewLayoutAttributes]()
    public var contentSize: CGSize = .zero
    
    override public var collectionViewContentSize: CGSize {
        return contentSize
    }
    
    override public func prepare() {
        super.prepare()
        cache.removeAll()
        calculateCellFrame()
    }
    
    override public func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                layoutAttributes.append(attributes)
            }
        }
        
        return layoutAttributes
    }
    
    override public func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
    
    public func calculateCellFrame() {}
}
