//
//  KiwiCVC.swift
//  Layout App
//
//  Created by Jack Ily on 24/06/2019.
//  Copyright © 2019 Jack Ily. All rights reserved.
//

import UIKit

class KiwiCVC: UICollectionViewController {
    
    //MARK: - UIView
    let containerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0))
    let topView = UIView()
    
    let onlineView = UIView()
    
    let kiwiLayout = KiwiLayout()
    
    //MARK: - Properties
    lazy var colors: [UIColor] = [UIColor(hex: 0xEA60A7)]
    
    
    
    lazy var numbers: [Int] = {
        return Array(1...colors.count)
    }()
    
    let color = UIColor(hex: 0x048CD6, alpha: 0.5)
    
    var removeView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0))
    var addView = UIView(frame: CGRect(x: 45.0, y: 0.0, width: 40.0, height: 40.0))
    var kNum = 1
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        addTopView(view,
                   collectionView: collectionView,
                   topView: topView,
                   selector: #selector(topDidTap),
                   controller: self)
        
        addItemBar(containerView,
                   viewColor: color,
                   navigationItem: navigationItem,
                   controller: self, selector: #selector(backDidTap))
        addRightBarButton()
    }
}

//MARK: - Setups

extension KiwiCVC {
    
    func setupCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(KiwiCVCell.self, forCellWithReuseIdentifier: "KiwiCVCell")
        
        collectionView.collectionViewLayout = kiwiLayout
        kiwiLayout.contentPadding = ItemsPadding(horizontal: 2.0, vertical: 10.0)
        
        navigationItem.title = "Kiwi"
    }
    
    func addRightBarButton() {
        let rightView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 85.0, height: 40.0))
        rightView.backgroundColor = .clear
        
        removeView.backgroundColor = UIColor(hex: 0xFF3534, alpha: 0.5)
        removeView.clipsToBounds = true
        removeView.layer.cornerRadius = 20.0
        
        addView.backgroundColor = color
        addView.clipsToBounds = true
        addView.layer.cornerRadius = 20.0
        
        rightView.addSubview(removeView)
        rightView.addSubview(addView)
        
        let removeIMG = UIImage(named: "icon-remove")!
        let addIMG = UIImage(named: "icon-add")!
        removeIMG.withRenderingMode(.alwaysTemplate)
        addIMG.withRenderingMode(.alwaysTemplate)
        
        let frame = CGRect(x: 7.5, y: 7.5, width: 25.0, height: 25.0)
        
        let removeImageView = UIImageView(frame: frame)
        removeImageView.image = removeIMG
        removeImageView.tintColor = .white
        
        let addImageView = UIImageView(frame: frame)
        addImageView.image = addIMG
        addImageView.tintColor = .white
        
        removeView.addSubview(removeImageView)
        addView.addSubview(addImageView)
        removeView.isUserInteractionEnabled = true
        addView.isUserInteractionEnabled = true
        removeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(removeDidTap)))
        addView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addDidTap)))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightView)
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
    
    @objc func removeDidTap() {
        addAnimation(removeView) {
            self.kNum = 1
            self.colors.removeAll()
            self.numbers.removeAll()
            self.colors.append(UIColor(hex: 0xEA60A7))
            self.numbers.append(1)
            self.onlineView.removeFromSuperview()
            self.collectionView.reloadData()
        }
    }
    
    @objc func addDidTap() {
        addAnimation(addView) {
            self.kNum += 1
            
            if self.kNum == 2 {
                self.colors.append(UIColor(hex: 0xDE834C))
                
            } else if self.kNum == 3 {
                self.colors.append(UIColor(hex: 0x4DA43A))
                
            } else if self.kNum == 4 {
                self.colors.append(UIColor(hex: 0x8C6FCA))
                
            } else {
                self.colors.removeLast()
                self.colors.append(UIColor(hex: 0xB3B3B3))
            }
            
            self.numbers.append(self.kNum)
            self.collectionView.reloadData()
        }
    }
}

//MARK: - UICollectionViewDataSource

extension KiwiCVC {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KiwiCVCell", for: indexPath) as! KiwiCVCell
        
        if kNum > 4 && indexPath.item == 3 {
            cell.nameLbl.text = "+\(kNum-3)"
            cell.containerView.backgroundColor = UIColor(hex: 0xB3B3B3)
            
            onlineView.removeFromSuperview()
            cell.addSubview(onlineView)
            onlineView.translatesAutoresizingMaskIntoConstraints = false
            onlineView.backgroundColor = .white
            
            let width = cell.frame.size.width * 0.5
            onlineView.widthAnchor.constraint(equalToConstant: width).isActive = true
            onlineView.heightAnchor.constraint(equalTo: onlineView.widthAnchor, multiplier: 1/1).isActive = true
            onlineView.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: width/2.0 - 50.0).isActive = true
            onlineView.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: width/2.0 - 35.0).isActive = true
            
            let insideView = UIView()
            addContainerViewInCell(onlineView, containerView: insideView, constant: 12.0)
            insideView.backgroundColor = UIColor(hex: 0x5FCC00)
            insideView.frame.size = CGSize(width: width-24.0,
                                           height: width-24.0)
            
            onlineView.clipsToBounds = true
            onlineView.layer.cornerRadius = width/2.0
            
            insideView.clipsToBounds = true
            insideView.layer.cornerRadius = insideView.frame.size.width/2.0
            
        } else {
            cell.nameLbl.text = "\(numbers[indexPath.item])"
        }
        
        cell.containerView.backgroundColor = colors[indexPath.item]
        cell.outsideView.backgroundColor = .white
        cell.containerView.clipsToBounds = true
        
        let cellSize = CGSize(width: cell.frame.size.width-30,
                              height: cell.frame.size.height-30)
        cell.containerView.layer.cornerRadius = cellSize.width/2.0
        cell.outsideView.layer.cornerRadius = cell.frame.size.width/2.0
        
        return cell
    }
}

//MARK: - UICollectionViewDelegate

extension KiwiCVC {}

//MARK: - UICollectionViewDelegateFlowLayout

extension KiwiCVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let inset = collectionView.contentInset
        let sizeItem = (collectionView.frame.size.width - (inset.left + inset.right + 10.0))/2.0
        
        return CGSize(width: sizeItem, height: sizeItem)
    }
}

//MARK: - UIScrollView

extension KiwiCVC {
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        hideNavigationBar(velocity, navigationC: navigationController)
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        appearTopView(scrollView, view: view, topView: topView)
    }
}
