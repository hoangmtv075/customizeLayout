//
//  MainVC.swift
//  Layout App
//
//  Created by Jack Ily on 22/06/2019.
//  Copyright © 2019 Jack Ily. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

    //MARK: - UIView
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    //MARK: - Properties
    lazy var items: [(name: String, color: UIColor)] = [
        (name: "Pinterest", color: UIColor(hex: 0xEA60A7)),
        (name: "Instagram", color: UIColor(hex: 0x9E62BE)),
        (name: "Flickr", color: UIColor(hex: 0x6899AE)),
        (name: "Flipboard", color: UIColor(hex: 0x4CCEDE)),
        (name: "Facebook", color: UIColor(hex: 0x048CD6)),
        (name: "Zala", color: UIColor(hex: 0xEA60A7)),
        (name: "Kiwi", color: UIColor(hex: 0x8C6FCA)),
        (name: "Tobaha", color: UIColor(hex: 0xDBE200)),
        (name: "Turn Pages", color: UIColor(hex: 0xCA916C)),
        (name: "Jack Ily", color: UIColor(hex: 0x8F9A9B)),
    ]
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Custom Layout"
    }
}

//MARK: - Setups

extension MainVC {
    
    func addCollectionView() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
        collectionView.register(MainCVCell.self, forCellWithReuseIdentifier: "MainCVCell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

//MARK: - UICollectionViewDataSource

extension MainVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCVCell", for: indexPath) as! MainCVCell
        let item = items[indexPath.item]
        
        cell.nameLbl.text = "\(item.name)"
        cell.containerView.backgroundColor = item.color
        
        return cell
    }
}

//MARK: - UICollectionViewDelegate

extension MainVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? MainCVCell else {
            return
        }
        
        let item = indexPath.item
        switch item {
        case 0:
            let pinterestCVC = PinterestCVC(collectionViewLayout: UICollectionViewFlowLayout())
            navigationController?.pushViewController(pinterestCVC, animated: true)
            break
            
        case 1:
            let instagramCVC = InstagramCVC(collectionViewLayout: UICollectionViewFlowLayout())
            navigationController?.pushViewController(instagramCVC, animated: true)
            break
            
        case 2:
            let flickrCVC = FlickrCVC(collectionViewLayout: UICollectionViewFlowLayout())
            navigationController?.pushViewController(flickrCVC, animated: true)
            break
            
        case 3:
            let flipboardCVC = FlipboardCVC(collectionViewLayout: UICollectionViewFlowLayout())
            navigationController?.pushViewController(flipboardCVC, animated: true)
            break
            
        case 4:
            let facebookCVC = FacebookCVC(collectionViewLayout: UICollectionViewFlowLayout())
            navigationController?.pushViewController(facebookCVC, animated: true)
            break
            
        case 5:
            let zalaCVC = ZalaCVC(collectionViewLayout: UICollectionViewFlowLayout())
            navigationController?.pushViewController(zalaCVC, animated: true)
            break
            
        case 6:
            let kiwiCVC = KiwiCVC(collectionViewLayout: UICollectionViewFlowLayout())
            navigationController?.pushViewController(kiwiCVC, animated: true)
            break
            
        case 7:
            let tobahaCVC = TobahaCVC(collectionViewLayout: UICollectionViewFlowLayout())
            navigationController?.pushViewController(tobahaCVC, animated: true)
            break
            
        case 8:
            let turnPagesCVC = TurnPagesCVC(collectionViewLayout: UICollectionViewFlowLayout())
            navigationController?.pushViewController(turnPagesCVC, animated: true)
            break
            
        default:
            navigationItem.title = "J.A.C.K  I.L.Y"
            break
        }
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension MainVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let inset = collectionView.contentInset
        let sizeItem = collectionView.frame.size.width - (inset.left + inset.right)
        
        return CGSize(width: sizeItem, height: sizeItem/6.0)
    }
}
