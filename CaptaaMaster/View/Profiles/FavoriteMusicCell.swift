//
//  FavoriteMusicCell.swift
//  CaptaaMaster
//
//  Created by Falilatu Aroworade on 5/5/20.
//  Copyright © 2020 Lawson Falomo. All rights reserved.
//

import UIKit



class FavoriteMusicCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    var user: User? {
        didSet { configure()}
    }
    
    
    
    
    lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.setDimensions(height: 65, width: 65)
        iv.layer.cornerRadius = 65 / 2
        iv.backgroundColor = .groupTableViewBackground
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(handleProfileImageTapped))
//        iv.addGestureRecognizer(tap)
//        iv.isUserInteractionEnabled = true
        
        return iv
    }()
    
    lazy var artistLabel: UILabel = {
        let label = UILabel()
        label.text = "Artist"
        label.textColor = .darkBlueMode
        label.font = UIFont(name: "AvenirNext-Bold", size: 10)
        label.textAlignment = .center
        return label
    }()

    

    
    
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        addSubview(profileImageView)
        profileImageView.center(inView: self)
        
        addSubview(artistLabel)
        artistLabel.anchor(top: profileImageView.bottomAnchor, left: leftAnchor, right: rightAnchor)
        artistLabel.setDimensions(height: 30, width: 30)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
//    @objc func handleProfileImageTapped() {
//        
//    }
//    
    
    
    // MARK: - Helpers
    
    func configure() {
        guard let user = user else { return}
        
        profileImageView.sd_setImage(with: user.profileImageUrl)
        
        artistLabel.text = user.fullname
    }
    
    
}
