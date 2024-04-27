//
//  TurnPagesCVCell.swift
//  Layout App
//
//  Created by Jack Ily on 29/06/2019.
//  Copyright © 2019 Jack Ily. All rights reserved.
//

import UIKit

class TurnPagesCVCell: UICollectionViewCell {
    
    var imageView = UIImageView()
    
    var dragon: Dragon! {
        didSet {
            imageView.image = dragon.image
        }
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        addContainerView()
    }
    
    func addContainerView() {
        //TODO: - ImageView
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
