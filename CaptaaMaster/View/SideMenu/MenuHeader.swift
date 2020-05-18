//
//  MenuHeader.swift
//  CaptaaMaster
//
//  Created by Falilatu Aroworade on 5/11/20.
//  Copyright © 2020 Lawson Falomo. All rights reserved.
//


import UIKit

class MenuHeader: UIView {
    
    // MARK: - Properties
    
    var user: User? {
        didSet { configure() }
    }
    
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .white
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    private let fullnameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Bold", size: 18)
        label.textColor = .white
        return label
    }()
    
 
    
    private let followingLabel = UILabel()
    
    private let followersLabel = UILabel()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .instagramColor
        
        
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, left: leftAnchor, paddingLeft: 12)
        profileImageView.setDimensions(height: 60, width: 60)
        profileImageView.layer.cornerRadius = 60 / 2
        
        let nameStack = UIStackView(arrangedSubviews: [fullnameLabel])
        nameStack.distribution = .fillEqually
        nameStack.axis = .vertical
        
        addSubview(nameStack)
        nameStack.anchor(top: profileImageView.bottomAnchor, left: leftAnchor, paddingTop: 12, paddingLeft: 16)
        
        let followStack = UIStackView(arrangedSubviews: [followingLabel, followersLabel])
        followStack.distribution = .fillEqually
        followStack.axis = .horizontal
        followStack.spacing = 16
        
        addSubview(followStack)
        followStack.anchor(top: nameStack.bottomAnchor,left: leftAnchor, paddingTop: 12, paddingLeft: 16)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configure() {
        guard let user = user else { return }
        let viewModel = ProfileHeaderViewModel(user: user)
        
        fullnameLabel.text = user.fullname
       
        profileImageView.sd_setImage(with: user.profileImageUrl)
        
        
        followingLabel.attributedText = viewModel.menuFollowingString
       
    }
}
