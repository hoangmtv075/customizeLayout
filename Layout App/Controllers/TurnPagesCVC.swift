//
//  TurnPagesCVC.swift
//  Layout App
//
//  Created by Jack Ily on 29/06/2019.
//  Copyright © 2019 Jack Ily. All rights reserved.
//

import UIKit

class TurnPagesCVC: UICollectionViewController {
    
    //MARK: - UIView
    let containerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0))
    let topView = UIView()
    
    let turnPagesLayout = TurnPagesLayout()
    
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
        
        let color = UIColor(hex: 0x048CD6, alpha: 0.5)
        addItemBar(containerView,
                   viewColor: color,
                   navigationItem: navigationItem,
                   controller: self, selector: #selector(backDidTap))
    }
}

//MARK: - Setups

extension TurnPagesCVC {
    
    func setupCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(TurnPagesCVCell.self, forCellWithReuseIdentifier: "TurnPagesCVCell")
        
        collectionView.collectionViewLayout = turnPagesLayout
        turnPagesLayout.scrollDirection = .horizontal
        turnPagesLayout.minimumLineSpacing = 0.0
        turnPagesLayout.minimumInteritemSpacing = 0.0
        
        navigationItem.title = "Turn Pages"
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

extension TurnPagesCVC {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1000
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TurnPagesCVCell", for: indexPath) as! TurnPagesCVCell
        cell.dragon = dragons[indexPath.item % dragons.count]
        return cell
    }
}

//MARK: - UICollectionViewDelegate

extension TurnPagesCVC {}

//MARK: - UICollectionViewDelegateFlowLayout

extension TurnPagesCVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return view.bounds.size
    }
}

//MARK: - UIScrollView

extension TurnPagesCVC {
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        hideNavigationBar(velocity, navigationC: navigationController)
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        appearTopView(scrollView, view: view, topView: topView)
    }
}
