//
//  UploadCaptionController.swift
//  CaptaaMaster
//
//  Created by Falilatu Aroworade on 5/1/20.
//  Copyright © 2020 Lawson Falomo. All rights reserved.
//

import UIKit
import ActiveLabel
import Firebase

class UploadCaptionController: UIViewController {
    
    // MARK: - Properties
    
    var user: User
    
        let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .twitterBlue
        button.setTitle("Add Caption +", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        button.setTitleColor(.white, for: .normal)
        
        button.frame = CGRect(x: 0, y: 0, width: 104, height: 32)
        button.layer.cornerRadius = 32 / 2
        
        button.addTarget(self, action: #selector(handleUploadCaption), for: .touchUpInside)
        
        return button
    }()
    
    
 
    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.setDimensions(height: 45, width: 45)
        iv.layer.cornerRadius = 45 / 2
        iv.backgroundColor = .groupTableViewBackground
        return iv
    }()
    
        private let captionTextView = CaptionTextView()
    
    private let hashtagTextView = HashtagTextView()

    
    // MARK: - Lifecycle
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - API
    
   func uploadHashtagToServer(withCaptionID captionId: String) {
    guard let hashtag = hashtagTextView.text else { return}
    
    let words: [String] = hashtag.components(separatedBy: .whitespacesAndNewlines)
    
    for var word in words {
        if word.hasPrefix("#") {
            word = word.trimmingCharacters(in: .punctuationCharacters)
            word = word.trimmingCharacters(in: .symbols)
            
            let hashtagValues = [captionId:1]
            
            HASHTAG_POST_REF.child(word.lowercased()).updateChildValues(hashtagValues)
        }
    }
    
   }
    
    
    
    
    // MARK: - Selectors
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleUploadCaption() {
        guard let caption = captionTextView.text else {return}
        guard let hastag = hashtagTextView.text else { return}
   
        let captionId = REF_CAPTIONS.childByAutoId()
      //  guard let captionKey = captionId.key else { return}
        
   
        
        CaptionService.shared.uploadCaption(caption: caption, hashtag: hastag) { (error, ref) in
          
            if let error = error {
                print("DEBUG Failed to upload caption with \(error.localizedDescription)")
                return
            }
            
            self.uploadHashtagToServer(withCaptionID: captionId.key!)
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    
    
    
    
    // MARK: - Helpers
    func configureUI() {
        view.backgroundColor = .white
        configureNavigationBar()
        
        let stack = UIStackView(arrangedSubviews: [profileImageView, captionTextView])
        stack.axis = .horizontal
        stack.spacing = 12
        stack.alignment = .leading
        
      
        view.addSubview(stack)
        stack.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingRight: 16)
        
        view.addSubview(hashtagTextView)
        hashtagTextView.anchor(top: stack.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 16)
        hashtagTextView.backgroundColor = .groupTableViewBackground
        
        
        profileImageView.sd_setImage(with: user.profileImageUrl, completed: nil)
        
        
    }
    
    
    
    
    
    
    func configureNavigationBar() {
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: actionButton)
    }
}
