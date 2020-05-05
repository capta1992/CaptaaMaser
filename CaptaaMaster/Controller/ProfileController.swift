//
//  ProfileController.swift
//  CaptaaMaster
//
//  Created by Falilatu Aroworade on 4/29/20.
//  Copyright © 2020 Lawson Falomo. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import SDWebImage

private let reuseIdentifier = "SaveCaptionCell"
private let headerIdentifier = "ProfileHeader"
private let musicIdentifier = "UserStoryFavoriteCell"

class ProfileController: UICollectionViewController {
    
    // MARK: - Propertties
    
    
    
    
    var user: User? {
        didSet{
            configureCollectionViewUI()
        }
    }
    
    private lazy var actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.backgroundColor = .twitterBlue
        button.setImage(UIImage(named: "new_tweet"), for: .normal)
        button.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        return button
    }()
    
     lazy var favoriteCollectionView: UICollectionView = {
           let layout = UICollectionViewFlowLayout()
           let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
           collection.backgroundColor = .twitterBlue
           layout.scrollDirection = .horizontal
           collection.isScrollEnabled = true
           collection.showsHorizontalScrollIndicator = false
           collection.translatesAutoresizingMaskIntoConstraints = false
           return collection
       }()
    
    
    
    // MARK: - Lifecycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionViewUI()
        fetchSavedCaptions()
        
      
        
    }
    
    
    
    // MARK: - API
    
    func fetchSavedCaptions() {
        CaptionService.shared.fetchSavedCaptions { (captions) in
            print("DEBUG: Captions are \(captions)")
        }
    }
    
    func authenticateUserAndConfigureUI() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        } else {
            fetchUser()
        }
    }
    
    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        UserService.shared.fetchUser(uid: uid) { user in
            self.user = user
        }
    }
    
    
    
    // MARK: - Selectors
    
    @objc func actionButtonTapped() {
        guard let user = user else {return}
        let controller = UploadCaptionController(user: user)
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }
    
    // MARK: - Helpers
    
    func configureCollectionViewUI(){
        collectionView.backgroundColor = .white
        
        
        favoriteCollectionView.delegate = self
        favoriteCollectionView.dataSource = self
        
        collectionView.addSubview(favoriteCollectionView)
        favoriteCollectionView.anchor(top: collectionView.safeAreaLayoutGuide.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor)
        
        navigationItem.title = "Profile"
        
        collectionView.register(SaveCaptionCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        collectionView.register(ProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
        
        favoriteCollectionView.register(UserStoryFavoriteCell.self, forCellWithReuseIdentifier: musicIdentifier)
        

        collectionView.addSubview(favoriteCollectionView)
        favoriteCollectionView.anchor(top: collectionView.topAnchor, paddingTop: 200)
      
        
        collectionView.addSubview(actionButton)
        actionButton.anchor(bottom: collectionView.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor,
                            paddingBottom: 30, paddingRight: 16, width: 56, height: 56)
        actionButton.layer.cornerRadius = 56 / 2
    }
    
}

// MARK: - UICollectionViewDelegate/Datasource

extension ProfileController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionView {
            return 5
        }
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionView {
            let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SaveCaptionCell
            
            return cellA
            
        } else {
            let cellB = favoriteCollectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SaveCaptionCell
            
            return cellB
        }
    }
    
}

extension ProfileController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 500)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 220)  
    }
    
}

extension ProfileController {
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! ProfileHeader
        
        return header
    }
}





