//
//  PinterestCVC.swift
//  Layout App
//
//  Created by Jack Ily on 22/06/2019.
//  Copyright © 2019 Jack Ily. All rights reserved.
//

import UIKit

class PinterestCVC: UICollectionViewController {
    
    //MARK: - UIView
    let containerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0))
    let topView = UIView()
    
    let pinterestLayout = PinterestLayout()
    
    //MARK: - Properties
    lazy var dragons: [Dragon] = {
        return Dragon.sharedInstance()
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        addTopView(view,
                   collectionView: collectionView,
                   topView: topView,
                   selector: #selector(topDidTap),
                   controller: self)
        
        let color = UIColor(hex: 0xEA60A7, alpha: 0.5)
        addItemBar(containerView,
                   viewColor: color,
                   navigationItem: navigationItem,
                   controller: self, selector: #selector(backDidTap))
    }
}

//MARK: - Setups

extension PinterestCVC {
    
    func setupCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 10.0, left: 2.0, bottom: 10.0, right: 2.0)
        collectionView.register(PinterestCVCell.self, forCellWithReuseIdentifier: "PinterestCVCell")
        
        collectionView.collectionViewLayout = pinterestLayout
        pinterestLayout.delegate = self
        pinterestLayout.cellPadding = 1.0
        collectionView.reloadData()
        
        navigationItem.title = "Pinterest"
    }
    
    @objc func backDidTap() {
        addAnimation(containerView) {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func topDidTap() {
        addAnimation(topView) {
            let indexPath = IndexPath(item: 0, section: 0)
            self.collectionView.scrollToItem(at: indexPath, at: .top, animated: true)
            self.topView.alpha = 0.0
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        }
    }
}

//MARK: - UICollectionViewDataSource

extension PinterestCVC {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PinterestCVCell", for: indexPath) as! PinterestCVCell
        cell.dragonImg = dragons[indexPath.item % dragons.count]
        return cell
    }
}

//MARK: - UICollectionViewDelegate

extension PinterestCVC {}

//MARK: - UICollectionViewDelegateFlowLayout

extension PinterestCVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let inset = collectionView.contentInset
        let sizeItem = (collectionView.frame.size.width - (inset.left + inset.right + 10.0))/2.0

        return CGSize(width: sizeItem, height: sizeItem)
    }
}

//MARK: - UIScrollView

extension PinterestCVC {
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        hideNavigationBar(velocity, navigationC: navigationController)
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        appearTopView(scrollView, view: view, topView: topView)
    }
}

//MARK: - PinterestLayoutDelegate

extension PinterestCVC: PinterestLayoutDelegate {
    
    func collectionView(heightForPhotoAt indexPath: IndexPath) -> CGFloat {
        return dragons[indexPath.item % dragons.count].image.size.height
    }
}
