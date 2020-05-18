//
//  SaveCaptionCell.swift
//  CaptaaMaster
//
//  Created by Falilatu Aroworade on 5/2/20.
//  Copyright © 2020 Lawson Falomo. All rights reserved.
//

import UIKit
import Firebase
import ActiveLabel

class SaveCaptionCell: UICollectionViewCell {
    
    // MARK: - Properties
    
      var caption: Caption? {
          didSet { configure()

          }
      }
    
    
    private let followCaptaaLabel: ActiveLabel = {
        let label = ActiveLabel()
        label.text = " → Follow us on Instagram @Captaa__"
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 12)
        label.mentionColor = .twitterBlue
        return label
    }()
    
    private lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.setDimensions(height: 40, width: 40)
        iv.layer.cornerRadius = 40 / 2
        iv.clipsToBounds = true
        iv.backgroundColor = UIColor.lightGray
        return iv
    }()
    
    private let infoLabel = UILabel()
    
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .left
        label.text = "11:57 AM - 04/21/2020"
        return label
    }()
    
    
    lazy var captionLabel: ActiveLabel = {
        let label = ActiveLabel()
        label.text = "Some test saved tweet weird #gocrazy"
        label.textColor = .black
        label.font = UIFont(name: "AvenirNext-Medium", size: 14)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var copyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "retweet"), for: .normal)
        button.setDimensions(height: 15, width: 15)
        button.tintColor = .backgroundColor
        //    button.addTarget(self, action: #selector(handleCopyTapped), for: .touchUpInside)
        return button
    }()
    
    
    
    private lazy var trashButtton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "trash.fill"), for: .normal)
        button.setDimensions(height: 15, width: 15)
        button.tintColor = .backgroundColor
        //     button.addTarget(self, action: #selector(handleCopyTapped), for: .touchUpInside)
        return button
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
    
    
    
    // MARK: - Heplers
    
    func configure() {
        guard let caption = caption else { return}
        
        let viewModel = CaptionViewModel(caption: caption)
        
        profileImageView.sd_setImage(with: viewModel.profileImageUrl)
        
        // CREATE A USERNAME FOR USERS EASIER TO SEARCH
        infoLabel.attributedText = viewModel.userInfoText
        captionLabel.text = caption.caption
        
    }
    
    
    
    func configureUI() {
        backgroundColor = .white
        
        addSubview(followCaptaaLabel)
        followCaptaaLabel.anchor(top: topAnchor, left: leftAnchor, paddingTop: 4, paddingLeft: 8)
        
        addSubview(profileImageView)
        profileImageView.anchor(top: followCaptaaLabel.bottomAnchor, left: leftAnchor, paddingTop: 12, paddingLeft: 8)
        
        addSubview(infoLabel)
        infoLabel.anchor(top: topAnchor, left: profileImageView.rightAnchor,
                            right: rightAnchor, paddingTop: 40,
                            paddingLeft: 8, paddingRight: 12)
        
     
        
        let captionStack = UIStackView(arrangedSubviews: [infoLabel, captionLabel])
        captionStack.axis = .vertical
        captionStack.distribution = .fillProportionally
        captionStack.spacing = 25
        
      
        
        
        addSubview(captionStack)
        captionStack.anchor(top: profileImageView.bottomAnchor, left: profileImageView.rightAnchor, paddingTop: -25, paddingLeft: 4)
        
        let actionStack = UIStackView(arrangedSubviews: [copyButton, trashButtton])
        actionStack.axis = .horizontal
        actionStack.distribution = .fillEqually
        actionStack.spacing = 20
        
        addSubview(actionStack)
        actionStack.anchor(top: captionStack.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 55)
        
        actionStack.setDimensions(height: 18, width: 18)
        
        
        let underlineView = UIView()
        underlineView.backgroundColor = .systemGroupedBackground
        addSubview(underlineView)
        underlineView.anchor(left: leftAnchor, bottom: bottomAnchor,
                             right: rightAnchor, height: 1)
        
        
    }
    
    
}


