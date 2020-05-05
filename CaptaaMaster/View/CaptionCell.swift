//
//  CaptionCell.swift
//  CaptaaMaster
//
//  Created by Falilatu Aroworade on 5/2/20.
//  Copyright © 2020 Lawson Falomo. All rights reserved.
//

import UIKit

protocol CapttionCellDelegate: class {
    func handleProfileImageTapped(_ cell: CaptionCell)
}

class CaptionCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    var caption: Caption? {
        didSet { configure()

        }
    }
    
    weak var delegate: CapttionCellDelegate?
    
    
    
    private lazy var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.setDimensions(height: 40, width: 40)
        iv.layer.cornerRadius = 40 / 2
        iv.clipsToBounds = true
        iv.backgroundColor = UIColor.lightGray
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleProfileImageTapped))
        iv.addGestureRecognizer(tap)
        iv.isUserInteractionEnabled = true
        
        return iv
        
    }()
    
    
    
    private lazy var verifiedButton: UIButton  = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "shapes-and-symbols").withRenderingMode(.alwaysOriginal), for: .normal)
        button.setDimensions(height: 13, width: 12)
        return button
    }()
    
    
    private lazy var optionsButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .lightGray
        button.setImage(UIImage(named: "down_arrow_24pt"), for: .normal)
        //   button.addTarget(self, action: #selector(showActionSheet), for: .touchUpInside)
        return button
    }()
    
    // we wantt this caption labels text to appear in the center of our post's image view
    private let captionLabel: UILabel = {
        let label = UILabel()
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
        
        
        
        
        // Add Gesture Recognizer For Double Tap To Like
        //   let likeTap = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTapToLike))
        //   likeTap.numberOfTapsRequired = 2
        //     iv.isUserInteractionEnabled = true
        //   iv.addGestureRecognizer(likeTap)
        
        return iv
    }()
    
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .left
        label.text = "11:57 AM - 04/21/2020"
        return label
    }()
    
    
    private lazy var statsView: UIView = {
        let view = UIView()
        
        let divider1 = UIView()
        divider1.backgroundColor = .systemGroupedBackground
        view.addSubview(divider1)
        divider1.anchor(top: view.topAnchor, left: view.leftAnchor,
                        right: view.rightAnchor, paddingLeft: 8, height: 1.0)
        
        let stack = UIStackView(arrangedSubviews: [retweetsLabel, likesLabel])
        stack.axis = .horizontal
        stack.spacing = 12
        
        view.addSubview(stack)
        stack.centerY(inView: view)
        stack.anchor(left: view.leftAnchor, paddingTop: 280, paddingLeft: 8)
        
        let divider2 = UIView()
        divider2.backgroundColor = .systemGroupedBackground
        view.addSubview(divider2)
        divider2.anchor(left: view.leftAnchor, bottom: view.bottomAnchor,
                        right: view.rightAnchor, paddingLeft: 8, height: 1.0)
        
        return view
    }()
    
    
    private lazy var retweetsLabel  = UILabel()
    
    private lazy var likesLabel = UILabel()
    
    
    private lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "like_selected"), for: .normal)
        button.setDimensions(height: 25, width: 25)
        button.tintColor = .systemRed
        button.addTarget(self, action: #selector(handleLikeTapped), for: .touchUpInside)
        return button
    }()
    
    
    private lazy var commentButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "comment"), for: .normal)
        button.setDimensions(height: 25, width: 25)
        button.tintColor = .darkGray
        button.addTarget(self, action: #selector(handleCommentTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var copyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "retweet"), for: .normal)
        button.setDimensions(height: 25, width: 25)
        button.tintColor = .systemGreen
        button.addTarget(self, action: #selector(handleCopyTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "share"), for: .normal)
        button.tintColor = .twitterBlue
        button.setDimensions(height: 25, width: 25)
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
    let hashtagLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    
  private let infoLabel = UILabel()

    
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        confugureUI()
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
    @objc func handleLikeTapped() {
        
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
        captionLabel.textColor = .black
        captionLabel.font = UIFont(name: "AmaticSC-Regular", size: 30)
        captionLabel.textAlignment = .center
        captionLabel.numberOfLines = 0
        
        retweetsLabel.text = "0 Copies"
        retweetsLabel.font = UIFont.systemFont(ofSize: 13)
        retweetsLabel.textColor = .lightGray
        
        likesLabel.text = "0 Likes"
        likesLabel.font = UIFont.systemFont(ofSize: 13)
        likesLabel.textColor = .lightGray
        
        profileImageView.sd_setImage(with: viewModel.profileImageUrl)
        
        // CREATE A USERNAME FOR USERS EASIER TO SEARCH
        infoLabel.attributedText = viewModel.userInfoText
        infoLabel.setDimensions(height: 80, width: 80)
        

        
    }
    

    
    func confugureUI() {
        backgroundColor = .white
        
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, left: leftAnchor, paddingTop: 12, paddingLeft: 8)
        
        let infoStack = UIStackView(arrangedSubviews: [infoLabel, verifiedButton])
        infoStack.axis = .horizontal
        infoStack.spacing = 20
        
        
        let captionStack = UIStackView(arrangedSubviews: [infoStack, postImageView])
        captionStack.axis = .vertical
        infoStack.distribution = .fillProportionally
        infoStack.spacing = 4
        
        addSubview(optionsButton)
        optionsButton.anchor(top: topAnchor, left: leftAnchor, paddingTop: 23, paddingLeft:  340)
        
        
        addSubview(captionStack)
        captionStack.anchor(top: profileImageView.bottomAnchor, left: profileImageView.rightAnchor, paddingTop: -30, paddingLeft: 8, paddingRight: 180)
        
        
        addSubview(dateLabel)
        dateLabel.anchor(top: captionStack.bottomAnchor, left: leftAnchor, paddingTop: 360, paddingLeft: 8)
        
        
        let actionStack = UIStackView(arrangedSubviews: [likeButton, commentButton, copyButton])
        
        addSubview(statsView)
        statsView.anchor(top: dateLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingBottom: 60)
        
        actionStack.axis = .horizontal
        actionStack.spacing = 35
        actionStack.distribution = .fillProportionally
        
        addSubview(actionStack)
        actionStack.anchor(top: statsView.bottomAnchor, left: leftAnchor, paddingTop: 12, paddingLeft: 4)
        
    
        
        addSubview(shareButton)
        shareButton.anchor(top: statsView.bottomAnchor, left: actionStack.rightAnchor, paddingTop: 10, paddingLeft: 180)
        
        
     

    }
    
}
