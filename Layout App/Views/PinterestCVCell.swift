//
//  PinterestCVCell.swift
//  Layout App
//
//  Created by Jack Ily on 22/06/2019.
//  Copyright © 2019 Jack Ily. All rights reserved.
//

import UIKit

class PinterestCVCell: UICollectionViewCell {
    
    var nameLbl = UILabel()
    var containerView = UIView()
    var dragonImageView = UIImageView()
    
    var dragonImg: Dragon! {
        didSet {
            dragonImageView.image = dragonImg.image
            nameLbl.text = dragonImg.name
        }
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        addContainerView()
    }
    
    func addContainerView() {
        //TODO: - ContainerView
        addContainerViewInCell(self, containerView: containerView)
        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = 5.0
        containerView.layer.borderWidth = 1.0
        containerView.layer.borderColor = UIColor(hex: 0x434343).cgColor
        
        //TODO: UIVisualEffectView
        let visualEffect = UIVisualEffectView()
        containerView.addSubview(visualEffect)
        visualEffect.effect = UIBlurEffect(style: .dark)
        visualEffect.translatesAutoresizingMaskIntoConstraints = false
        
        visualEffect.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        visualEffect.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        visualEffect.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        visualEffect.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        
        //TODO: - NameLabel
        visualEffect.contentView.addSubview(nameLbl)
        nameLbl.translatesAutoresizingMaskIntoConstraints = false
        nameLbl.font = UIFont(name: fontNamed2, size: 20.0)
        nameLbl.textAlignment = .center
        nameLbl.textColor = .white

        nameLbl.centerXAnchor.constraint(equalTo: visualEffect.centerXAnchor).isActive = true
        nameLbl.centerYAnchor.constraint(equalTo: visualEffect.centerYAnchor).isActive = true
        
        //TODO: UIImageView
        containerView.addSubview(dragonImageView)
        dragonImageView.translatesAutoresizingMaskIntoConstraints = false
        dragonImageView.contentMode = .scaleAspectFill
        dragonImageView.clipsToBounds = true
        
        dragonImageView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        dragonImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        dragonImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        dragonImageView.bottomAnchor.constraint(equalTo: visualEffect.topAnchor).isActive = true
    }
}
