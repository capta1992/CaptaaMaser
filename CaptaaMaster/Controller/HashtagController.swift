//
//  HashtagController.swift
//  CaptaaMaster
//
//  Created by Falilatu Aroworade on 5/13/20.
//  Copyright © 2020 Lawson Falomo. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "HashtagCell"
private let headerIdentifier = "HashtagHeader"

class HashtagController: UICollectionViewController {
    
    // MARK: - Properties
    
    private var user: User?
    
    
    var hashtags = [Caption]()
    
    var hashtag: String?
    
    // MARK: - Lifecycle
   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        
        
        
    }
    
    
    // MARK: - Selectors
    
    
    
    // MARK: - Helpers
    
    func configureCollectionView() {
    
        collectionView.backgroundColor = .white
    //    collectionView.contentInsetAdjustmentBehavior = .never
        
        navigationItem.title = "Hashtags"
        
        
        collectionView.register(HashtagCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.register(HashtagHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
        
    }
    
}

extension HashtagController {
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! HashtagHeader
        
        return header
    }
}



extension HashtagController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! HashtagCell
        
//        cell.caption = hashtags[indexPath.row]
        return cell
    }
}

extension HashtagController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 300)
    }
    
    
func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = (view.frame.width - 2) / 3
    return CGSize(width: width, height: width)
}

}
