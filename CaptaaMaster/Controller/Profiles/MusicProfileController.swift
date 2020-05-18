//
//  MusicProfileController.swift
//  CaptaaMaster
//
//  Created by Falilatu Aroworade on 5/7/20.
//  Copyright © 2020 Lawson Falomo. All rights reserved.
//

import UIKit
import Firebase

private let reuseIdentifier = "MusicProfileCell"
private let headerIdentifier = "MusicProfileHeader"


class MusicProfileController: UICollectionViewController {
    
    // MARK: - Properties
    
    private var user: User
    
    private var captions = [Caption]() {
        didSet { collectionView.reloadData()}
    }

    
    
    // MARK: - Lifecycle
    
    init(user: User) {
        self.user = user
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        fetchCaptions()
        checkIfUserIsFollowed()
        fetchUserStats()
        
        
    }
    
    // MARK: - API
    
    func fetchCaptions() {
        CaptionService.shared.fetchCaptions(forUser: user) { (captions) in
            self.captions = captions
        }
    }
    
    func checkIfUserIsFollowed() {
        UserService.shared.checkIfUserIsFollowed(uid: user.uid ?? "nil") { (isFollowed) in
            self.user.isFollowed = isFollowed
            self.collectionView.reloadData()
        }
    }
    
    
    func fetchUserStats() {
        UserService.shared.fetchUserStats(uid: user.uid ?? "nil") {stat in
            self.user.stats = stat
            self.collectionView.reloadData()
        }
        
    }


    // MARK: - Selectors
    
    
    // MARK: - Helpers
    
    func configureCollectionView() {
        
      
        collectionView.backgroundColor = .white
        
        
    
        collectionView.register(MusicProfileCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.register(MusicProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
        
    }
    
}

// MARK: UICollectionView For Users Posts Header is Below

extension MusicProfileController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return captions.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MusicProfileCell
        
        cell.caption = captions[indexPath.row]
        return cell
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}


extension MusicProfileController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 2) / 3
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
           return 1
       }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = CaptionController(caption: captions[indexPath.row])
        controller.indexPathToScroll = indexPath
        navigationController?.pushViewController(controller, animated: true)
    }
    
    // MARK: UICollectionViewLayout THIS IS WHERE THE HEADER BEIGINS
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 350)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! MusicProfileHeader
        
        header.user = user
        header.delegate = self
        return header
    }
    
}

extension MusicProfileController: MusicHeaderDelegate {
    
    func handleEditProfileFollow(_ header: MusicProfileHeader) {
        
        if user.isCurrentUser {
            print("DEBUG: Show edit profile Controller")
            return
        }
        
        
        if user.isFollowed {
            UserService.shared.unfollowUser(uid: user.uid!) { (err, ref) in
                self.user.isFollowed = false
                self.collectionView.reloadData()
                            
            }
            
        } else {
            
            UserService.shared.followUser(uid: user.uid!) { (ref, err) in
                self.user.isFollowed = true
                self.collectionView.reloadData()
                
                
                NotificationService.shared.uploadNotification(type: .follow, user: self.user)
          
            }
            
        }
    }
}

extension MusicProfileController: EditProfileControllerDelegate {
    func controller(_ controller: EditProfileController, wantsToUpdate user: User) {
        controller.dismiss(animated: true, completion: nil)
        self.user = user
        self.collectionView.reloadData()
    }
    
    
}
