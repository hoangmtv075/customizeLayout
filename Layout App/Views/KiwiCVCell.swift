//
//  KiwiCVCell.swift
//  Layout App
//
//  Created by Jack Ily on 24/06/2019.
//  Copyright © 2019 Jack Ily. All rights reserved.
//

import UIKit

class KiwiCVCell: UICollectionViewCell {
    
    var nameLbl = UILabel()
    var containerView = UIView()
    var outsideView = UIView()
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        backgroundColor = .clear
        addContainerView()
    }
    
    func addContainerView() {
        //TODO: - ContainerView
        addSubview(outsideView)
        outsideView.translatesAutoresizingMaskIntoConstraints = false
        outsideView.clipsToBounds = true
        
        outsideView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        outsideView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        outsideView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        outsideView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        addContainerViewInCell(outsideView, containerView: containerView, constant: 15.0)
        
        addLabelInCell(containerView, nameLbl: nameLbl)
    }
}
