//
//  ProfileHeader.swift
//  CaptaaMaster
//
//  Created by Falilatu Aroworade on 5/3/20.
//  Copyright © 2020 Lawson Falomo. All rights reserved.
//

import UIKit

class ProfileHeader: UICollectionReusableView {
    
    // MARK: - Properties
    
    private lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.setDimensions(height: 150, width: 150)
        iv.layer.cornerRadius = 150 / 2
        iv.clipsToBounds = true
        iv.backgroundColor = UIColor.lightGray
        return iv
    }()
    
        private lazy var addArtistImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.setDimensions(height: 40, width: 40)
        iv.layer.cornerRadius = 40 / 2
        iv.clipsToBounds = true
        iv.backgroundColor = UIColor.lightGray
        return iv
    }()
    
    
    
    private let infoLabel = UILabel()
    
    
    private lazy var verifiedButton: UIButton  = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "shapes-and-symbols").withRenderingMode(.alwaysOriginal), for: .normal)
        button.setDimensions(height: 13, width: 12)
        return button
    }()
    
    
    lazy var followingLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        let attributedText = NSMutableAttributedString(string: "6\n", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: "Following", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.lightGray]))
        label.attributedText = attributedText
        
        // add gesture recognizer
        //   let followTap = UITapGestureRecognizer(target: self, action: #selector(handleFollowingTapped))
        //     followTap.numberOfTapsRequired = 1
        //    label.isUserInteractionEnabled = true
        //     label.addGestureRecognizer(followTap)
        return label
    }()
    
    lazy var editProfileFollowButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Loading", for: .normal)
        button.layer.cornerRadius = 3
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 0.5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.black, for: .normal)
        //   button.addTarget(self, action: #selector(handleEditProfileFollow), for: .touchUpInside)
        return button
    }()
    
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 3
        label.text = "This is where we will place the bios in the music controllers "
        return label
    }()
    
    let favoriteMusicStoriesLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Keep your favorite artists on your profile"
        label.font = UIFont.systemFont(ofSize: 11)
        return label
    }()
    
    
      let musicHighlightsLabel: UILabel = {
          let label = UILabel()
          label.numberOfLines = 0
          label.text = "Music Highlights"
          label.font = UIFont.boldSystemFont(ofSize: 13)
          return label
      }()
    

    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        congigureUI()
        
        
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
    
    // MARK: - Helpers
    
    func congigureUI() {
        backgroundColor = .white
        
        addSubview(profileImageView)
        profileImageView.anchor(top: safeAreaLayoutGuide.topAnchor, left: leftAnchor, paddingTop: 20, paddingLeft: 120)
        
        let stack = UIStackView(arrangedSubviews: [infoLabel, verifiedButton])
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        
        addSubview(stack)
        stack.anchor(top: profileImageView.bottomAnchor, left: leftAnchor,paddingTop: 8, paddingLeft:  160)
        
        infoLabel.text = "Moyo Falomo"
        infoLabel.textColor = .black
        infoLabel.font = UIFont.boldSystemFont(ofSize: 12)
        
        addSubview(followingLabel)
        followingLabel.anchor(top: stack.bottomAnchor, left: leftAnchor, paddingTop: 12, paddingLeft: 170)
        
        addSubview(editProfileFollowButton)
        editProfileFollowButton.anchor(top: followingLabel.bottomAnchor, left: leftAnchor, paddingTop: 8, paddingLeft: 50, width: 300)
        
         addSubview(bioLabel)
        bioLabel.anchor(top: editProfileFollowButton.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingLeft: 12)
        bioLabel.setDimensions(height: 50, width: 50)
        
        
        addSubview(musicHighlightsLabel)
        musicHighlightsLabel.anchor(top: bioLabel.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 16, paddingLeft: 8 )
        
       
        
        
        addSubview(favoriteMusicStoriesLabel)
        favoriteMusicStoriesLabel.anchor(top: musicHighlightsLabel.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 8)
        
        
        
       
        
    }
    
}
