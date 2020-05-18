//
//  EditProfileHeader.swift
//  CaptaaMaster
//
//  Created by Falilatu Aroworade on 5/14/20.
//  Copyright © 2020 Lawson Falomo. All rights reserved.
//

import UIKit

protocol EditProfileHeaderDelegate: class {
    func didTapChangeProfilePhoto()
}

class EditProfileHeader: UIView {
    
    // MARK: - Properties
    private let user: User
    weak var delegate: EditProfileHeaderDelegate?
    
    
    lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .groupTableViewBackground
        iv.layer.borderColor = UIColor.white.cgColor
        iv.layer.borderWidth = 3.0
        return iv
    }()
    
   private lazy var changePhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Change Profile Photo", for: .normal)
        button.addTarget(self, action: #selector(handleChangeProfilePhoto), for: .touchUpInside)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    
    // MARK: - Lifecycle
    
    init(user: User) {
        self.user = user
        super.init(frame: .zero)
        
        backgroundColor = .instagramColor
        
        addSubview(profileImageView)
        profileImageView.center(inView: self, yConstant: -16)
        profileImageView.setDimensions(height: 100, width: 100)
        profileImageView.layer.cornerRadius = 100 / 2
        
        addSubview(changePhotoButton)
        changePhotoButton.centerX(inView: self, topAnchor: profileImageView.bottomAnchor, paddingTop: 8)
        
        profileImageView.sd_setImage(with: user.profileImageUrl)
        
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
    @objc func handleChangeProfilePhoto() {
        delegate?.didTapChangeProfilePhoto()
    }
    
}


    
    

