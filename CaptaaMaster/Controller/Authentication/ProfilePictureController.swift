//
//  ProfilePictureController.swift
//  CaptaaMaster
//
//  Created by Falilatu Aroworade on 4/30/20.
//  Copyright © 2020 Lawson Falomo. All rights reserved.
//


import UIKit
import Firebase

class ProfilePictureController: UIViewController {
    
    // MARK: - Properties
    
    var user: User!
    
    private let iconImage = UIImageView(image: #imageLiteral(resourceName: "captaalogo").withRenderingMode(.alwaysOriginal))
    private let dividerView = SeperatorView()
    private let imagePicker = UIImagePickerController()
    
    private var profileImage: UIImage?
    
    
    private let pickProfileImagePicture: UILabel = {
        let label = UILabel()
        label.text = "Pick a profile picture"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 26)
        return label
    }()
    
    private let profilePictureInstructionLabel: UILabel = {
        let label = UILabel()
        label.text = "Have a favorite selfie? Upload it now."
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    private let plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plus_photo-1"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handleAddProfilePhoto), for: .touchUpInside)
        return button
    }()
    
    private lazy var actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(showSuggestionController), for: .touchUpInside)
        return button
    }()
    
    private let goBackButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        attributedTitle.append(NSAttributedString(string: "Skip for now", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.mainBlueTint]))
        
        button.addTarget(self, action: #selector(handleGoBack), for: .touchUpInside)
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }()
    
    
    
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
        
    }
    
    // MARK: - Selectors
    
    @objc func handleGoBack() {
        navigationController?.popViewController(animated: true)
    }
    
    
    @objc func showSuggestionController() {
        
        guard let profileImage = profileImage else {
            print("DEBUG: please select profile photo")
            return
        }
        
        guard let imageData = profileImage.jpegData(compressionQuality: 0.3) else {return}
        let filename = NSUUID().uuidString
        let storageRef = STORAGE_PROFILE_IMAGES.child(filename)
        
        storageRef.putData(imageData, metadata: nil) { (meta, error) in
            storageRef.downloadURL { (url, error) in
                guard let profileImageUrl = url?.absoluteString else {return}
                
                let dic = [
                    "email": self.user.email,
                    "fullname": self.user.fullname,
                    "profileImageUrl": profileImageUrl
                ] as [String: AnyObject]
                
                
                
                REF_USERS.child(self.user.uid!).updateChildValues(dic) { (err, ref) in
                    print("DEBUG: got the user and the profile picture hopfully")
                    print("DEBUG: hanfle user interface here for now ")
                    
                    
                    let controller = SuggestionsController()
                    self.navigationController?.pushViewController(controller, animated: true)
                    
                }
                
            }
        }
        
        
        
     
        
        
            
    
     
        
    }
    
    @objc func handleAddProfilePhoto() {
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    
    func configureNavigationUI() {
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isHidden = true
        
    }
    
    
    
    // MARK: - Helper
    
    func configureUI() {
        view.backgroundColor = .backgroundColor
        configureNavigationUI()
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        view.addSubview(iconImage)
        iconImage.centerX(inView: view)
        iconImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 0)
        
        iconImage.setDimensions(height: 25, width: 25)
        iconImage.clipsToBounds = true
        iconImage.contentMode = .scaleAspectFit
        
        view.addSubview(pickProfileImagePicture)
        pickProfileImagePicture.anchor(top: iconImage.bottomAnchor, left: view.leftAnchor, paddingTop: 35, paddingLeft: 8)
        
        view.addSubview(profilePictureInstructionLabel)
        profilePictureInstructionLabel.anchor(top: pickProfileImagePicture.bottomAnchor, left: view.leftAnchor, paddingTop: 15, paddingLeft: 8)
        
        view.addSubview(plusPhotoButton)
        plusPhotoButton.centerX(inView: view, topAnchor: profilePictureInstructionLabel.bottomAnchor, paddingTop: 40)
        plusPhotoButton.setDimensions(height: 200, width: 200)
        
        
        
        view.addSubview(dividerView)
        dividerView.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 100, paddingRight: 0 )
        
        
        view.addSubview(actionButton)
        actionButton.anchor(top: dividerView.bottomAnchor, left: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 0, paddingBottom: 0, paddingRight: 8)
        
        view.addSubview(goBackButton)
        goBackButton.anchor(top: dividerView.bottomAnchor, left: view.leftAnchor, right: nil, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 8)
        
        
        actionButton.backgroundColor = .twitterBlue
        actionButton.setTitle("Next", for: .normal)
        actionButton.titleLabel?.textAlignment = .center
        actionButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        actionButton.setTitleColor(.white, for: .normal)
        actionButton.frame = CGRect(x: 0, y: 0, width: 64, height: 32)
        actionButton.setDimensions(height: 32, width: 64)
        actionButton.layer.cornerRadius = 32 / 2
        
        
        
        actionButton.bindToKeyboard()
        dividerView.bindToKeyboard()
        goBackButton.bindToKeyboard()
    }
}

// MARK: - UIImagePickerControllerDelegate

extension ProfilePictureController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let profileImage = info[.editedImage] as? UIImage else {return}
        self.profileImage = profileImage
        
        plusPhotoButton.layer.cornerRadius = 200 / 2
        plusPhotoButton.layer.masksToBounds = true
        plusPhotoButton.imageView?.contentMode = .scaleAspectFill
        plusPhotoButton.imageView?.clipsToBounds = true
        plusPhotoButton.layer.borderColor = UIColor.white.cgColor
        plusPhotoButton.layer.borderWidth = 3
        
        self.plusPhotoButton.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        dismiss(animated: true, completion: nil)
    }
}

