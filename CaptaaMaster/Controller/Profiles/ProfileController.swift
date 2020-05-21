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

    
    private var selectedFilter: ProfileFilterOptions = .savedCaptions {
        didSet {collectionView.reloadData() }
    }
    
    
    var user: User? {
        didSet{
            configureCollectionViewUI()
             collectionView.reloadData()
            fetchCaptions()
            fetchLikedCaptions()
            fetchPersonalCaptions()
        }
    }
    
    private var savedCaptions = [Caption]()
    private var likedCaptions = [Caption]()
    private var personalCaptions = [Caption]()
    
    private var currentDatasource: [Caption] {
        switch selectedFilter {
        case.savedCaptions: return savedCaptions
        case.likedCaption: return likedCaptions
        case.personal: return personalCaptions
            
        }
    }
        
    // MARK: - Lifecycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        configureCollectionViewUI()
        fetchUser()
        fetchCaptions()
        fetchLikedCaptions()
        fetchPersonalCaptions()
        fetchUserStats()
        fetchFollowingUsers()
        
   //     fetchSavedCaptions()
    
    }
    
    
    
    // MARK: - API
    
    func fetchLikedCaptions() {
        guard let user = user else { return}
        CaptionService.shared.fetchLikes(forUser: user) { (captions) in
            self.likedCaptions = captions
        }
    }
    
    func fetchPersonalCaptions() {
        personalCaptions.shuffle()
        collectionView.refreshControl?.beginRefreshing()
        CaptionService.shared.fetchCaptions { (captions) in
            self.personalCaptions = captions
            self.personalCaptions.shuffle()
            self.collectionView.refreshControl?.endRefreshing()
            
        }
    }
    

    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        UserService.shared.fetchUser(uid: uid) { user in
            self.user = user
            
        }
    }
    
    func fetchFollowingUsers() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        UserService.shared.fetchUserFllowingUsers(uid: uid, completion: {_,_ in
            
        })
    }
    
    func fetchCaptions() {
        guard let user = user else { return}
        CaptionService.shared.fetchCaptions(forUser: user) { (caption) in
            self.savedCaptions = caption
            self.collectionView.reloadData()
            
        }
    }
    
    func fetchUserStats() {
        guard let user = user else { return}
        UserService.shared.fetchUserStats(uid: user.uid!) {stats in
            self.user?.stats = stats
                  self.collectionView.reloadData()
              }
    }
    
    
    
    // MARK: - Selectors
    
 
    
    // MARK: - Helpers
    
    func presentController(_ controller: UIViewController) {
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }
    
    func configureCollectionViewUI(){
        collectionView.backgroundColor = .white
        
        
        guard let tabHeight = tabBarController?.tabBar.frame.height else { return}
        collectionView.contentInset.bottom = tabHeight
        
    
        
        navigationItem.title = "Profile"
        
        collectionView.register(SaveCaptionCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        collectionView.register(ProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
    
    }
    
}

// MARK: - UICollectionViewDelegate/Datasource

extension ProfileController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentDatasource.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SaveCaptionCell
            cell.caption = currentDatasource[indexPath.row]
            return cell
    }
    
}

extension ProfileController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 500) // 500
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let viewModel = CaptionViewModel(caption: currentDatasource[indexPath.row])
        let height = viewModel.size(forWidth: view.frame.width).height
        return CGSize(width: view.frame.width, height: height + 172)
    }
   
}

extension ProfileController {
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! ProfileHeader
        
        
        header.user = user
        header.delegate = self
        return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = CaptionController(caption: currentDatasource[indexPath.row])
        controller.indexPathToScroll = indexPath
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension ProfileController: ProfileHeaderDelegate {
    
    
    func didSelect(filter: ProfileFilterOptions) {
        self.selectedFilter = filter
    }
    
    func handleEditProfileFollow(_ header: ProfileHeader) {
        let controller = EditProfileController(user: user!)
        controller.delegate = self
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
        
    }
    
    
}


extension ProfileController: EditProfileControllerDelegate {
    func controller(_ controller: EditProfileController, wantsToUpdate user: User) {
        controller.dismiss(animated: true, completion: nil)
        self.user = user
        self.collectionView.reloadData()
    }
    
    
}

    
    

    
    



