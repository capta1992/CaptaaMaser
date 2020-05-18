//
//  CaptionHeader.swift
//  CaptaaMaster
//
//  Created by Falilatu Aroworade on 5/10/20.
//  Copyright © 2020 Lawson Falomo. All rights reserved.
//

import UIKit


protocol CaptionHeaderDelegate: class {
    func showActionSheet()
}


class CaptionHeader: UICollectionReusableView {
    
    // MARK: - Properties
    
    var caption: Caption? {
        didSet { configure()}
    }
    
    weak var delegate: CaptionHeaderDelegate?
    

    
    lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.setDimensions(height: 48, width: 48)
        iv.layer.cornerRadius = 48 / 2
        iv.backgroundColor = .twitterBlue
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleProfileImageTapped))
        iv.addGestureRecognizer(tap)
        iv.isUserInteractionEnabled = true
        
        return iv
    }()
    
    
    lazy var verifiedButton: UIButton  = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "shapes-and-symbols").withRenderingMode(.alwaysOriginal), for: .normal)
        button.setDimensions(height: 13, width: 12)
        return button
    }()
    
    
    lazy var optionsButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .lightGray
        button.setImage(UIImage(named: "down_arrow_24pt"), for: .normal)
        button.addTarget(self, action: #selector(showActionSheet), for: .touchUpInside)
        return button
    }()
    
    lazy var captionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "AmaticSC-Regular", size: 30)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    
    lazy var postImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .twitterBlue
        iv.clipsToBounds = true
        iv.backgroundColor = UIColor.lightGray
        
        addSubview(self.captionLabel)
        self.captionLabel.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: -50)
        
        self.captionLabel.text = "Some Test Caption"
        
        
        return iv
    }()
    
    
    lazy var retweetsLabel:  UILabel = {
        let label = UILabel()
        label.text = "0 Copy"
        label.font = UIFont(name: "AvenirNext-Medium", size: 12)
        return label
    }()
    
    
    lazy var likesLabel: UILabel = {
        let label = UILabel()
        label.text = "0 Likes"
        label.font = UIFont(name: "AvenirNext-Medium", size: 12)
        return label
    }()
    
    
    lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "like_unselected"), for: .normal)
        button.setDimensions(height: 20, width: 20)
        button.tintColor = .black
        //     button.addTarget(self, action: #selector(handleLikeTapped), for: .touchUpInside)
        return button
    }()
    
    
    
    private lazy var copyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "retweet"), for: .normal)
        button.setDimensions(height: 20, width: 20)
        button.tintColor = .darkGray
        button.addTarget(self, action: #selector(showActionSheet), for: .touchUpInside)
        return button
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .left
        label.text = "6:33 PM - 1/28/2020"
        return label
    }()
    
    
    lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.setDimensions(height: 100, width: 100)
        return label
    }()
    
    private lazy var shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "share"), for: .normal)
        button.tintColor = .black
        button.setDimensions(height: 20, width: 20)
        button.addTarget(self, action: #selector(showActionSheet), for: .touchUpInside)
        return button
    }()
    
    
    
    lazy var statsView: UIView = {
        let view = UIView()
        
        
        let stack = UIStackView(arrangedSubviews: [retweetsLabel, likesLabel])
        stack.axis = .horizontal
        stack.spacing = 12
        
        view.addSubview(stack)
        stack.centerY(inView: view)
        stack.anchor(left: view.leftAnchor, paddingTop: 280, paddingLeft: 8)
        
        
        return view
    }()
    
    
    
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, left: leftAnchor, paddingTop: 12, paddingLeft: 8)
        
        let infoStack = UIStackView(arrangedSubviews: [infoLabel, verifiedButton])
        infoStack.axis = .horizontal
        infoStack.spacing = 10
        
        infoLabel.setDimensions(height: 100, width: 100)
        
        
        let captionStack = UIStackView(arrangedSubviews: [infoStack, postImageView])
        captionStack.axis = .vertical
        
        
        
        addSubview(optionsButton)
        optionsButton.anchor(top: topAnchor, left: leftAnchor, paddingTop: 23, paddingLeft:  340)
        
        
        addSubview(captionStack)
        captionStack.anchor(top: profileImageView.bottomAnchor, left: profileImageView.rightAnchor, paddingTop: -30, paddingLeft: 8, paddingRight: 180)
        
        addSubview(dateLabel)
        dateLabel.anchor(top: captionStack.bottomAnchor, left: leftAnchor, paddingTop: 350, paddingLeft: 8)
        
        
        let actionStack = UIStackView(arrangedSubviews: [likeButton, copyButton])
        
        addSubview(statsView)
        statsView.anchor(top: captionStack.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 370, paddingBottom: 60)
        
        
        
        actionStack.axis = .horizontal
        actionStack.spacing = 35
        actionStack.distribution = .fillProportionally
        
        addSubview(actionStack)
        actionStack.anchor(top: statsView.bottomAnchor, left: leftAnchor, paddingTop: 12, paddingLeft: 4)
        
        
        
        addSubview(shareButton)
        shareButton.anchor(top: statsView.bottomAnchor, left: actionStack.rightAnchor, paddingTop: 10, paddingLeft: 250)
        
        
    
        let underlineView = UIView()
        underlineView.backgroundColor = .systemGroupedBackground
        addSubview(underlineView)
        underlineView.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, height: 1)
        
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
    @objc func showActionSheet() {
        delegate?.showActionSheet()
    }
    
    

    @objc func handleProfileImageTapped() {
        print("DEBUG: profile image was tapped")
    }
    
    
    func configure() {
        guard let caption = caption else { return}
        let viewModel = CaptionViewModel(caption: caption)
        
        captionLabel.text = caption.caption
        infoLabel.text = caption.user.fullname
        profileImageView.sd_setImage(with: viewModel.profileImageUrl)
        dateLabel.text = viewModel.headerTimeStamp
        
        likesLabel.attributedText = viewModel.likesString
        retweetsLabel.attributedText = viewModel.copyString
        
        likeButton.setImage(viewModel.likeButtonImage, for: .normal)
        likeButton.tintColor = viewModel.likeButtonTintColor
        
    }
    
    // MARK: - Helpers
    
    
    
}
