//
//  ExploreCell.swift
//  CaptaaMaster
//
//  Created by Falilatu Aroworade on 5/7/20.
//  Copyright © 2020 Lawson Falomo. All rights reserved.
//

import UIKit

class ExploreCell: UITableViewCell {
    
    // MARK: - Properties
    
    var user: User? {
        didSet { configure()}
    }
    
    
    lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.setDimensions(height: 45, width: 45)
        iv.layer.cornerRadius = 45 / 2
        iv.clipsToBounds = true
        iv.backgroundColor = UIColor.lightGray
        return iv
    }()
    
    lazy var fullnameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "AvenirNext-Bold", size: 12)
        label.text = "Full Name"
        return label
    }()
    
    lazy var verifiedButton: UIButton  = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "shapes-and-symbols").withRenderingMode(.alwaysOriginal), for: .normal)
        button.setDimensions(height: 13, width: 12)
        return button
    }()
    
    
    lazy var popularLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont(name: "AvenirNext-Medium", size: 12)
        label.text = "Popular"
        return label
    }()
    
    lazy var followButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Follow", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "AvenirNext-Medium", size: 12)
        button.backgroundColor =  .instagramColor
//        button.addTarget(self, action: #selector(handleFollowTapped), for: .touchUpInside)
        return button
    }()
    

    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(profileImageView)
        profileImageView.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 12)
        
        let stack = UIStackView(arrangedSubviews: [fullnameLabel, popularLabel])
        stack.axis = .vertical
        stack.spacing = 2
        
        addSubview(stack)
        stack.centerY(inView: profileImageView, leftAnchor: profileImageView.rightAnchor, paddingLeft: 12)
        
    
        addSubview(followButton)
        followButton.anchor(top: nil, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 12, width: 90, height: 30)
        followButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        followButton.layer.cornerRadius = 3
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - API
    
    
    // MARK: - Selectors
    
    
    // MARK: - Helpers
    
    func configure() {
        guard let user = user else { return}
        
        profileImageView.sd_setImage(with: user.profileImageUrl)
        
        fullnameLabel.text = user.fullname
        
    
        
    }
    
}
