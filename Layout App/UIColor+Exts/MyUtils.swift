//
//  MyUtils.swift
//  Layout App
//
//  Created by Jack Ily on 22/06/2019.
//  Copyright © 2019 Jack Ily. All rights reserved.
//

import UIKit

public func addItemBar(_ containerView: UIView,
                       viewColor: UIColor,
                       navigationItem: UINavigationItem,
                       controller: UIViewController,
                       selector: Selector) {
    containerView.backgroundColor = viewColor
    containerView.clipsToBounds = true
    containerView.layer.cornerRadius = 20.0
    
    let backImageView = UIImageView(frame: CGRect(x: 10.0, y: 7.5, width: 25.0, height: 25.0))
    let image = UIImage(named: "icon-back")!
    image.withRenderingMode(.alwaysTemplate)
    backImageView.image = image
    backImageView.tintColor = .white
    containerView.addSubview(backImageView)
    
    navigationItem.leftBarButtonItem = UIBarButtonItem(customView: containerView)
    containerView.isUserInteractionEnabled = true
    containerView.addGestureRecognizer(UITapGestureRecognizer(target: controller, action: selector))
}

public func addAnimation(_ view: UIView, completion: @escaping () -> Void) {
    view.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
    
    UIView.animate(withDuration: 0.1,
                   animations: {
                    view.transform = .identity
    },
                   completion: { _ in
                    completion()
    })
}

public func addTopView(_ view: UIView,
                       collectionView: UIView,
                       topView: UIView,
                       selector: Selector,
                       controller: UIViewController) {
    view.insertSubview(topView, aboveSubview: collectionView)
    topView.translatesAutoresizingMaskIntoConstraints = false
    topView.backgroundColor = UIColor(white: 0.5, alpha: 0.8)
    topView.clipsToBounds = true
    topView.layer.cornerRadius = 20.0
    topView.addGestureRecognizer(UITapGestureRecognizer(target: controller, action: selector))
    
    topView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0).isActive = true
    topView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50.0).isActive = true
    topView.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
    topView.widthAnchor.constraint(equalToConstant: 40.0).isActive = true
    
    let imageView = UIImageView()
    let image = UIImage(named: "icon-top")!
    image.withRenderingMode(.alwaysTemplate)
    topView.addSubview(imageView)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.clipsToBounds = true
    imageView.image = image
    imageView.contentMode = .scaleAspectFit
    imageView.tintColor = .white
    
    imageView.topAnchor.constraint(equalTo: topView.topAnchor, constant: 0.0).isActive = true
    imageView.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 5.0).isActive = true
    imageView.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -5.0).isActive = true
    imageView.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -5.0).isActive = true
    
    topView.alpha = 0.0
}

public func addContainerViewInCell(_ view: UIView, containerView: UIView, constant: CGFloat = 0.0) {
    view.addSubview(containerView)
    containerView.translatesAutoresizingMaskIntoConstraints = false
    
    containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: constant).isActive = true
    containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: constant).isActive = true
    containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -constant).isActive = true
    containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -constant).isActive = true
}

public func addLabelInCell(_ containerView: UIView, nameLbl: UILabel) {
    //TODO: - NameLabel
    containerView.addSubview(nameLbl)
    nameLbl.translatesAutoresizingMaskIntoConstraints = false
    nameLbl.font = UIFont(name: fontNamed2, size: 70.0)
    nameLbl.textAlignment = .center
    nameLbl.textColor = .white
    
    nameLbl.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
    nameLbl.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
    nameLbl.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
    nameLbl.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
}

public func hideNavigationBar(_ velocity: CGPoint, navigationC: UINavigationController?) {
    if velocity.y > 0 {
        UIView.animate(withDuration: 0.25,
                       animations: {
                        navigationC?.setNavigationBarHidden(true, animated: true)
        },
                       completion: nil)
        
    } else {
        UIView.animate(withDuration: 0.25,
                       animations: {
                        navigationC?.setNavigationBarHidden(false, animated: true)
        },
                       completion: nil)
    }
}

public func appearTopView(_ scrollView: UIScrollView, view: UIView, topView: UIView) {
    if scrollView.contentOffset.y > view.frame.size.height {
        UIView.animate(withDuration: 0.5) {
            topView.alpha = 1.0
        }
        
    } else {
        UIView.animate(withDuration: 0.5) {
            topView.alpha = 0.0
        }
    }
}

public let fontNamed2 = "Zorque-Regular"
