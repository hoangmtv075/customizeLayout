//
//  MainCVCell.swift
//  Layout App
//
//  Created by Jack Ily on 22/06/2019.
//  Copyright © 2019 Jack Ily. All rights reserved.
//

import UIKit

class MainCVCell: UICollectionViewCell {
    
    var nameLbl = UILabel()
    var containerView = UIView()
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        addContainerView()
    }
    
    func addContainerView() {
        //TODO: - ContainerView
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = frame.size.height/2.0
        
        containerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        //TODO: - NameLabel
        containerView.addSubview(nameLbl)
        nameLbl.translatesAutoresizingMaskIntoConstraints = false
        nameLbl.font = UIFont(name: fontNamed2, size: 30.0)
        nameLbl.textAlignment = .center
        nameLbl.textColor = .white
        
        nameLbl.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        nameLbl.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
    }
}
