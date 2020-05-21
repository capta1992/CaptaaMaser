//
//  FavoriteMusicView.swift
//  CaptaaMaster
//
//  Created by Falilatu Aroworade on 5/5/20.
//  Copyright © 2020 Lawson Falomo. All rights reserved.
//

import UIKit
import FirebaseDatabase

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
        
        fetchMusicUsers()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fetchMusicUsers() {
        Database.database().reference().child("music").observe(.childAdded) { (snapshot) in
            // uid
            let uid = snapshot.key
            
            Database.fetchUser(with: uid, completion: { (user) in
                self.users.append(user)
                self.collectionView.reloadData()
            })
            
        }
    }
}



extension FavoriteMusicView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: favoriteMusicIdentifier, for: indexPath) as! FavoriteMusicCell
      
        //      cell.delegate = self
        cell.user = self.users[indexPath.row]
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
    

