//
//  HashtagHeader.swift
//  CaptaaMaster
//
//  Created by Falilatu Aroworade on 5/13/20.
//  Copyright © 2020 Lawson Falomo. All rights reserved.
//

import UIKit

class HashtagHeader: UICollectionReusableView {
    
    // MARK: - Properties
    
    lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.setDimensions(height: 130, width: 130)
        iv.backgroundColor = .twitterBlue
        
     
        
     
        return iv
    }()
    
    lazy var hashtagLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Bold", size: 17)
        label.text = "#baddie"
        return label
    }()
    
    lazy var hashtagCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Medium", size: 8)
        label.textColor = .lightGray
        label.text = "89.0M Views"
        return label
    }()
    
    lazy var hashtagDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Medium", size: 14)
        label.textColor = .lightGray
        label.numberOfLines = 10
        label.text = "Captaa hashtags show captions relevent to the post. These hashtags also work well with instagram hashtags. Get your post seen more, and increase user engagement!"
        return label
    }()
    

    
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, left: leftAnchor, paddingTop: 10, paddingLeft: 8)
        
        addSubview(hashtagLabel)
        hashtagLabel.anchor(top:topAnchor, right: profileImageView.rightAnchor, paddingTop: 15,  paddingRight: -80)
    
        addSubview(hashtagDescription)
        hashtagDescription.anchor(top: profileImageView.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: -5, paddingLeft: 8)
        hashtagDescription.setDimensions(height: 100, width: 200)
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
    
    
    // MARK: - Helpers
    
    
    
    
}
