//
//  ZalaCVCell.swift
//  Layout App
//
//  Created by Jack Ily on 24/06/2019.
//  Copyright © 2019 Jack Ily. All rights reserved.
//

import UIKit

class ZalaCVCell: UICollectionViewCell {
    
    var nameLbl = UILabel()
    var containerView = UIView()
    var color: Color! {
        didSet {
            containerView.backgroundColor = color.color
        }
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        addContainerView()
    }
    
    func addContainerView() {
        //TODO: - ContainerView
        addContainerViewInCell(self, containerView: containerView)
        addLabelInCell(containerView, nameLbl: nameLbl)
    }
}

