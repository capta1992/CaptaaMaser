//
//  CaptionController.swift
//  CaptaaMaster
//
//  Created by Falilatu Aroworade on 5/10/20.
//  Copyright © 2020 Lawson Falomo. All rights reserved.
//

import UIKit

private let reuseIdentifier = "MusicProfileCell"
private let headerIdentifier = "CaptionHeader"

class CaptionController: UICollectionViewController {
    
    // MARK: - Properties
    
    var indexPathToScroll: IndexPath?
    
    private let caption: Caption
    
    private var actionSheetLauncher: ActionSheetLauncher!
    
    
    // MARK: - Lifecycle
    
    init(caption: Caption) {
        self.caption = caption
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //      self.collectionView.scrollToItem(at: indexPathToScroll ?? IndexPath(item: 0, section: 0), at: .centeredVertically, animated: true)
    }
    
    
    
    // MARK: - Selectors
    
    
    
    // MARK: - Helpers
    
    
    fileprivate func showActionSheet(forUser user: User) {
        actionSheetLauncher = ActionSheetLauncher(user: user)
        actionSheetLauncher.delegate = self
        actionSheetLauncher.show()
    }
    
    
    
    func configureCollectionView() {
        collectionView.backgroundColor = .white
        
        navigationItem.title = "Captions"
        
        collectionView.register(MusicProfileCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        
        collectionView.register(CaptionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
        
        
        self.collectionView.layoutIfNeeded()
        self.collectionView.scrollToItem(at: indexPathToScroll ?? IndexPath(item: 0, section: 0), at: .centeredVertically, animated: true)
    }
    
}

// MARK: - UICollectionView DataSource

extension CaptionController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MusicProfileCell
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CaptionController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 500)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 120)
    }
}

extension CaptionController {
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! CaptionHeader
        
        header.delegate = self
        header.caption = caption
        return header
    }
    
}

extension CaptionController: CaptionHeaderDelegate {
    func showActionSheet() {
        if caption.user.isCurrentUser {
            showActionSheet(forUser: caption.user)
        } else {
            UserService.shared.checkIfUserIsFollowed(uid: caption.user.uid ?? "nil") { (isFollowed) in
                var user = self.caption.user
                user.isFollowed = isFollowed
                self.showActionSheet(forUser: user)
            }
            
        }
        
    }
    
}
extension CaptionController: ActionSheetLauncherDelegate {
    func didSelect(option: ActionSheetOptions) {
        switch option {
        case .follow(let user):
            UserService.shared.followUser(uid: user.uid ?? "nil") { (err, ref) in
            }
        case .unfollow(let user):
            UserService.shared.unfollowUser(uid: user.uid ?? "nil") { (err, ref) in
            }
        case .report:
            print("DEBUG: report tweet")
        case .delete:
            print("DEBUG: delette tweet")
        }
    }
    
    
}
