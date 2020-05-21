//
//  CaptionCell.swift
//  CaptaaMaster
//
//  Created by Falilatu Aroworade on 5/2/20.
//  Copyright © 2020 Lawson Falomo. All rights reserved.
//

import UIKit
import ActiveLabel


protocol CaptionCellDelegate: class {
    func handleLikeTapped(_ cell: CaptionCell)
    func handleHastagTapped(_ cell: CaptionCell)
    func handleProfileImageTapped(_ cell: CaptionCell)
}

protocol FeedShareDelegate {
    func postImageToInstagram(image: UIImage)
}



class CaptionCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    
    var caption: Caption? {
        didSet { configure()}
    }
    
    weak var delegate: CaptionCellDelegate?
    
    var shareDelegate: FeedShareDelegate?
    
    
    
    lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.setDimensions(height: 48, width: 48)
        iv.layer.cornerRadius = 48 / 2
        iv.backgroundColor = .groupTableViewBackground
        
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
    
    // we wantt this caption labels text to appear in the center of our post's image view
    lazy var captionLabel: ActiveLabel = {
        let label = ActiveLabel()
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
        self.captionLabel.anchor(top: self.topAnchor, left: self.leftAnchor, right: self.rightAnchor)
        
        addSubview(self.hashtagLabel)
        self.hashtagLabel.anchor(top: self.captionLabel.bottomAnchor, left: self.leftAnchor, bottom: self.bottomAnchor,right: self.rightAnchor,paddingLeft: 8, paddingBottom: 20)
        
        
        // Add Gesture Recognizer For Double Tap To Like
        //   let likeTap = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTapToLike))
        //   likeTap.numberOfTapsRequired = 2
        //     iv.isUserInteractionEnabled = true
        //   iv.addGestureRecognizer(likeTap)
        
        return iv
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
    
    
    lazy var retweetsLabel:  UILabel = {
        let label = UILabel()
        return label
    }()
    
    
    lazy var likesLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    
    lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "like_unselected"), for: .normal)
        button.setDimensions(height: 20, width: 20)
        button.tintColor = .black
        button.addTarget(self, action: #selector(handleLikeTapped), for: .touchUpInside)
        return button
    }()
    
    
    
 
    
    private lazy var copyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "retweet"), for: .normal)
        button.setDimensions(height: 22, width: 22)
        button.tintColor = .darkGray
        button.addTarget(self, action: #selector(handleCopyTapped), for: .touchUpInside)
        return button
    }()
    
     lazy var exportToInstagram: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "share"), for: .normal)
        button.tintColor = .black
        button.setDimensions(height: 22, width: 22)
        button.addTarget(self, action: #selector(handleShareButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var expandButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Expand ↡", for: .normal)
        button.tintColor = .twitterBlue
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        return button
    }()
    
    // make sure to incorporae active label to incorporate hashtags
    lazy var hashtagLabel: ActiveLabel = {
        let label = ActiveLabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "AvenirNext-Medium", size: 13)
        label.textColor = .twitterBlue
        
      //  Add Gesture Recognizer For Double Tap To Like
           let hashtagTap = UITapGestureRecognizer(target: self, action: #selector(handleHastagTapped))
           hashtagTap.numberOfTapsRequired = 1
            label.isUserInteractionEnabled = true
           label.addGestureRecognizer(hashtagTap)
        
        
        
        return label
    }()
    
    
    lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.setDimensions(height: 100, width: 100)
        return label
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
        
        
        let actionStack = UIStackView(arrangedSubviews: [copyButton, likeButton, exportToInstagram])
        
        addSubview(statsView)
        statsView.anchor(top: captionStack.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 370, paddingBottom: 60)
        
        actionStack.axis = .horizontal
        actionStack.spacing = 35
        actionStack.distribution = .fillProportionally
        
        addSubview(actionStack)
        actionStack.anchor(top: statsView.bottomAnchor, left: leftAnchor, paddingTop: -52, paddingLeft: 4)
        
        
        
        addSubview(exportToInstagram)
        exportToInstagram.anchor(top: statsView.bottomAnchor, left: actionStack.rightAnchor, paddingTop: -15, paddingLeft: 250)
        
        exportToInstagram.isHidden = true
        
   
        hashtagLabel.textColor = .instagramColor
        
        
        let underlineView = UIView()
        underlineView.backgroundColor = .systemGroupedBackground
        addSubview(underlineView)
        underlineView.anchor(left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, height: 1)
        
        
        
        
        
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
    
    @objc func handleHastagTapped() {
        delegate?.handleHastagTapped(self)
    }
    
    
    @objc func showActionSheet() {
    }
    
    @objc func handleLikeTapped() {
        delegate?.handleLikeTapped(self)
    }
    
    
    @objc func handleCommentTapped() {
        
    }
    
    @objc func handleCopyTapped() {
        
    }
    
    @objc func handleShareButton() {
        
    }
    
    @objc func handleProfileImageTapped() {
        delegate?.handleProfileImageTapped(self)
    }
    
    
    
    //MARK: - Helpers
    
    
    func configure() {
        guard let caption = caption else { return}
      

        let viewModel = CaptionViewModel(caption: caption)
        
        captionLabel.text = caption.caption
        
        profileImageView.sd_setImage(with: viewModel.profileImageUrl)
        
        infoLabel.attributedText = viewModel.userInfoText
        
        likesLabel.attributedText = viewModel.likesString
        retweetsLabel.attributedText = viewModel.copyString
        
        likeButton.tintColor = viewModel.likeButtonTintColor
        likeButton.setImage(viewModel.likeButtonImage, for: .normal)
        
        hashtagLabel.text = caption.hashtag
        
    }

        
}
