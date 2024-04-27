//
//  ZalaCVC.swift
//  Layout App
//
//  Created by Jack Ily on 24/06/2019.
//  Copyright © 2019 Jack Ily. All rights reserved.
//

import UIKit

class ZalaCVC: UICollectionViewController {
    
    //MARK: - UIView
    let containerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0))
    let topView = UIView()
    
    let zalaLayout = ZalaLayout()
    
    //MARK: - Properties
    lazy var colors: [Color] = {
        return Color.sharedInstance()
    }()
    
    lazy var numbers: [Int] = {
        return Array(1...1000)
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
        
        let color = UIColor(hex: 0x048CD6, alpha: 0.5)
        addItemBar(containerView,
                   viewColor: color,
                   navigationItem: navigationItem,
                   controller: self, selector: #selector(backDidTap))
    }
}

//MARK: - Setups

extension ZalaCVC {
    
    func setupCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(ZalaCVCell.self, forCellWithReuseIdentifier: "ZalaCVCell")
        
        collectionView.collectionViewLayout = zalaLayout
        zalaLayout.contentPadding = ItemsPadding(horizontal: 2.0, vertical: 10.0)
        zalaLayout.cellPadding = 2.0
        
        navigationItem.title = "Zala"
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

extension ZalaCVC {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1000
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ZalaCVCell", for: indexPath) as! ZalaCVCell
        
        cell.nameLbl.text = "\(numbers[indexPath.item])"
        cell.color = colors[indexPath.item % colors.count]
        
        return cell
    }
}

//MARK: - UICollectionViewDelegate

extension ZalaCVC {}

//MARK: - UICollectionViewDelegateFlowLayout

extension ZalaCVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let inset = collectionView.contentInset
        let sizeItem = (collectionView.frame.size.width - (inset.left + inset.right + 10.0))/2.0
        
        return CGSize(width: sizeItem, height: sizeItem)
    }
}

//MARK: - UIScrollView

extension ZalaCVC {
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        hideNavigationBar(velocity, navigationC: navigationController)
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        appearTopView(scrollView, view: view, topView: topView)
    }
}
