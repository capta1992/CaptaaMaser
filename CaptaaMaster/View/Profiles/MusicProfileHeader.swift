//
//  MusicProfileHeader.swift
//  CaptaaMaster
//
//  Created by Falilatu Aroworade on 5/7/20.
//  Copyright © 2020 Lawson Falomo. All rights reserved.
//

import UIKit


protocol MusicHeaderDelegate: class {
    func handleEditProfileFollow(_ header: MusicProfileHeader)
}


class MusicProfileHeader: UICollectionReusableView {
    
    // MARK: - Properties
    var user: User? {
        didSet{ configure()}
    }
    
    weak var delegate: MusicHeaderDelegate?
    
    
    private lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.setDimensions(height: 110, width: 110)
        iv.layer.cornerRadius = 110 / 2
        iv.clipsToBounds = true
        iv.backgroundColor = .groupTableViewBackground
        return iv
    }()
    
    private let infoLabel = UILabel()
  
    
    
    
    
    private lazy var verifiedButton: UIButton  = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "shapes-and-symbols").withRenderingMode(.alwaysOriginal), for: .normal)
        button.setDimensions(height: 13, width: 12)
        return button
    }()
    
    
    lazy var followersLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        let attributedText = NSMutableAttributedString(string: "6\n", attributes: [NSAttributedString.Key.font: UIFont(name: "AvenirNext-Bold", size: 18)!])
        attributedText.append(NSAttributedString(string: "Followers", attributes: [NSAttributedString.Key.font: UIFont(name: "AvenirNext-Medium", size: 12)!, NSAttributedString.Key.foregroundColor: UIColor.lightGray]))
        label.attributedText = attributedText
        
        //    add gesture recognizer
        let followTap = UITapGestureRecognizer(target: self, action: #selector(handleFollowersTapped))
        followTap.numberOfTapsRequired = 1
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(followTap)
        return label
    }()
    
    
      lazy var editProfileFollowButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Loading", for: .normal)
        button.layer.cornerRadius = 3
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 0.5
        button.titleLabel?.font = UIFont(name: "AvenirNext-Bold", size: 12)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .instagramColor
        button.addTarget(self, action: #selector(handleEditProfileFollow), for: .touchUpInside)
        return button
    }()
    
    
    lazy var instagramButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "instagram"), for: .normal)
        button.tintColor = .instagramColor
        button.setDimensions(height: 30, width: 50)
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.lightGray.cgColor
        return button
    }()
    
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Medium", size: 14)
        label.numberOfLines = 3
        return label
    }()
    
    
    let gridButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "grid"), for: .normal)
        button.setDimensions(height: 30, width: 30)
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
    
    @objc func handleDissmisal() {
        print("DEBUG: back button was tapped")
    }
    
    
    @objc func handleFollowersTapped() {
        print("DEBUG: Followers label was tapped")
    }
    
    @objc func handleEditProfileFollow() {
        delegate?.handleEditProfileFollow(self)
    }
    
    
    
    // MARK: - Helpers
    
    func configure() {
        guard let user = user else { return}
        let viewModel = MusicProfileHeaderViewModel(user: user)
        
        infoLabel.text = user.fullname
        profileImageView.sd_setImage(with: user.profileImageUrl)
        editProfileFollowButton.setTitle(viewModel.actionButtonTitle, for: .normal)
        followersLabel.attributedText = viewModel.followersString
        
        bioLabel.text = user.bio
    }
    
  
    
    func configureUI() {
        
        configureBottomToolBar()
        
        let stack = UIStackView(arrangedSubviews: [profileImageView, infoLabel,followersLabel])
        stack.axis = .vertical
        stack.spacing = 8
        
        addSubview(stack)
        stack.centerX(inView: self, topAnchor: safeAreaLayoutGuide.topAnchor, paddingTop: 8)
        profileImageView.setDimensions(height: 128, width: 128)
    
               
        addSubview(verifiedButton)
        verifiedButton.anchor(top: profileImageView.bottomAnchor,right: infoLabel.rightAnchor, paddingTop: 7, paddingRight: -5)
        
        
        infoLabel.textColor = .black
        infoLabel.textAlignment = .center
        infoLabel.font = UIFont.boldSystemFont(ofSize: 13)
        
        let followInstagramStack = UIStackView(arrangedSubviews: [editProfileFollowButton, instagramButton])
        followInstagramStack.axis = .horizontal
        followInstagramStack.spacing = 4
        
        
        addSubview(followInstagramStack)
        followInstagramStack.anchor(top: followersLabel.bottomAnchor, left: leftAnchor, paddingTop: 8, paddingLeft: 50,width: 250, height: 40)
        
        addSubview(bioLabel)
        bioLabel.anchor(top: followInstagramStack.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 16, paddingLeft: 120)
        
        
    }
    
    
    func configureBottomToolBar() {
        
        let topDividerView = UIView()
        topDividerView.backgroundColor = .lightGray
        
        let bottomDividerView = UIView()
        bottomDividerView.backgroundColor = .lightGray
        
        let stackView = UIStackView(arrangedSubviews: [gridButton]) // listbutton, boolmarkbutton
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
        addSubview(topDividerView)
        addSubview(bottomDividerView)
        
        stackView.anchor(top: nil, left: leftAnchor, bottom: self.bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
        topDividerView.anchor(top: stackView.topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
        
        bottomDividerView.anchor(top: stackView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
        
    }
    
}
