//
//  ProfileHeader.swift
//  CaptaaMaster
//
//  Created by Falilatu Aroworade on 5/3/20.
//  Copyright © 2020 Lawson Falomo. All rights reserved.
//

import UIKit

protocol ProfileHeaderDelegate: class {
    func handleEditProfileFollow(_ header: ProfileHeader)
    func didSelect(filter: ProfileFilterOptions)
    func clickUser(user:User)
}





class ProfileHeader: UICollectionReusableView {
    
    // MARK: - Properties
    
    private let filterBar = ProfileFilterView()
    
    private let favoriteMusicBar = FavoriteMusicView()
    
    
    
    var user: User? {
        didSet { configure()}
    }
    
    weak var delegate: ProfileHeaderDelegate?
    
    
    
    
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
    
    
    
    lazy var followingLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        let attributedText = NSMutableAttributedString(string: "6\n", attributes: [NSAttributedString.Key.font: UIFont(name: "AvenirNext-Bold", size: 18)!])
        attributedText.append(NSAttributedString(string: "Following", attributes: [NSAttributedString.Key.font: UIFont(name: "AvenirNext-Medium", size: 12)!, NSAttributedString.Key.foregroundColor: UIColor.lightGray]))
        label.attributedText = attributedText
        
    //    add gesture recognizer
        let followTap = UITapGestureRecognizer(target: self, action: #selector(handleFollowingTapped))
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
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.black, for: .normal)
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
    
   
    
        let favoriteHighlightLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Favorite Highlights"
        label.textColor = .black
        label.font = UIFont(name: "AvenirNext-Bold", size: 15)
        return label
    }()
    

    
    let musicHighlightsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Keep your favorite artists on your profile"
        label.textColor = .lightGray
        label.font = UIFont(name: "AvenirNext-Medium", size: 13)
        return label
    }()
    
 
    
    // MARK: - Lifecycle
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        configure()
        congigureUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
    @objc func handleEditProfileFollow() {
        delegate?.handleEditProfileFollow(self)
    }
    
    
    @objc func handleFollowingTapped() {
        print("DEBUG: followers button was tapped")
    }
    
    // MARK: - Helpers
    

    func configureBottomToolBar() {
        
        let topDividerView = UIView()
        topDividerView.backgroundColor = .lightGray
        
        let bottomDividerView = UIView()
        bottomDividerView.backgroundColor = .groupTableViewBackground
        

        
        addSubview(filterBar)
        addSubview(topDividerView)
        addSubview(bottomDividerView)
        
 
        
        filterBar.anchor(left: leftAnchor, bottom: self.bottomAnchor, right: rightAnchor, paddingBottom: 40, height: 50)
        topDividerView.anchor(top: filterBar.topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 5, height: 0.5)
        bottomDividerView.anchor(top: filterBar.bottomAnchor, left: leftAnchor, right: rightAnchor, height: 0.5)
        
        
    }
    
    
    
    
    func configure() {
        guard let user = user else {return}
        let viewModel = ProfileHeaderViewModel(user: user)
        
        profileImageView.sd_setImage(with: user.profileImageUrl)
        
        followingLabel.attributedText = viewModel.followingString
        
        editProfileFollowButton.setTitle(viewModel.actionButttonTitle, for: .normal)
        profileImageView.sd_setImage(with: user.profileImageUrl)
        
        infoLabel.text = user.fullname
        
        
        
        
    }
    
    func congigureUI() {
        backgroundColor = .white
        
        filterBar.delegate = self
        
        
        
        let stack = UIStackView(arrangedSubviews: [profileImageView, infoLabel,followingLabel])
        stack.axis = .vertical
        stack.spacing = 8
        
        addSubview(stack)
        stack.centerX(inView: self, topAnchor: safeAreaLayoutGuide.topAnchor, paddingTop: 8)
        profileImageView.setDimensions(height: 128, width: 128)
        profileImageView.sd_setImage(with: user?.profileImageUrl)
        
        
        infoLabel.textColor = .black
        infoLabel.textAlignment = .center
        infoLabel.font = UIFont.boldSystemFont(ofSize: 13)
        
        let followInstagramStack = UIStackView(arrangedSubviews: [editProfileFollowButton, instagramButton])
        followInstagramStack.axis = .horizontal
        followInstagramStack.spacing = 4
        
        
        
        
        addSubview(followInstagramStack)
        followInstagramStack.anchor(top: followingLabel.bottomAnchor, left: leftAnchor, paddingTop: 8, paddingLeft: 50,width: 250, height: 40)
        
        
        
        addSubview(favoriteHighlightLabel)
        favoriteHighlightLabel.anchor(top: followInstagramStack.bottomAnchor, left: leftAnchor, paddingTop: 16, paddingLeft: 8)
        
        
        addSubview(musicHighlightsLabel)
        musicHighlightsLabel.anchor(top: favoriteHighlightLabel.bottomAnchor, left: leftAnchor, paddingTop: 4, paddingLeft: 8 )
        
        addSubview(favoriteMusicBar)
        favoriteMusicBar.delegate = self
        favoriteMusicBar.anchor(top: musicHighlightsLabel.bottomAnchor,left: leftAnchor, right: rightAnchor, height: 120)
        
     
        
        configureBottomToolBar()
        
        
    }
    
}

extension ProfileHeader: ProfileFilterViewDelegate {
    func filterView(_ view: ProfileFilterView, didSelect index: Int) {
        guard let filter = ProfileFilterOptions(rawValue: index) else { return}
        
        delegate?.didSelect(filter: filter)
    }
    
    
}

extension ProfileHeader: FavoriteMusicViewDelegate {
    func clickFavoriteUser(user: User) {
        delegate?.clickUser(user: user)
    }
    
    
}




    
    

