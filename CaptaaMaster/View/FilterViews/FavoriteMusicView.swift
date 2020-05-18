//
//  FavoriteMusicView.swift
//  CaptaaMaster
//
//  Created by Falilatu Aroworade on 5/5/20.
//  Copyright © 2020 Lawson Falomo. All rights reserved.
//

import UIKit

private let favoriteMusicIdentifier = "FavoriteMusicCell"




class FavoriteMusicView: UIView {
    
    // MARK: - Properties
    
    var users = [User]()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        layout.scrollDirection = .horizontal
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    
    
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        collectionView.register(FavoriteMusicCell.self, forCellWithReuseIdentifier: favoriteMusicIdentifier)
        
        addSubview(collectionView)
        collectionView.addConstraintsToFillView(self)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



extension FavoriteMusicView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: favoriteMusicIdentifier, for: indexPath) as! FavoriteMusicCell
      
        //      cell.delegate = self
        return cell
}
    
    

}

extension FavoriteMusicView: UICollectionViewDelegate {
   

}

extension FavoriteMusicView: UICollectionViewDelegateFlowLayout {
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       return CGSize(width: frame.width / 3, height: frame.height)
    }
}

    
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
       return 0
    }
    

