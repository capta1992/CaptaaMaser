//
//  CategoryCell.swift
//  CaptaaMaster
//
//  Created by Falilatu Aroworade on 5/4/20.
//  Copyright © 2020 Lawson Falomo. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.setDimensions(height: 40, width: 40)
        iv.layer.cornerRadius = 40 / 2
        iv.clipsToBounds = true
        iv.backgroundColor = UIColor.lightGray
        
      //  let tap = UITapGestureRecognizer(target: self, action: #selector(handleProfileImageTapped))
     //   iv.addGestureRecognizer(tap)
   //     iv.isUserInteractionEnabled = true
        
        return iv
        
    }()


    
    // MARK: - Lifecycle
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
    
    
    // MARK: - Helpers
    
    func configureUI() {
        backgroundColor = .white
        
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
        
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.setDimensions(height: 50, width: 50)
        profileImageView.layer.cornerRadius = 50 / 2
        profileImageView.clipsToBounds = true
        profileImageView.backgroundColor = UIColor.lightGray    }
    
    
}
