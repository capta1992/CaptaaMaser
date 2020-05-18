//
//  BaseViewController.swift
//  CaptaaMaster
//
//  Created by Falilatu Aroworade on 5/2/20.
//  Copyright © 2020 Lawson Falomo. All rights reserved.
//

import UIKit
import FirebaseAuth

class BaseViewController: UIViewController {
    
    var user: User?{
        didSet{
            configureLeftBarButton()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.authenticateUserAndConfigureUI()
    }
    
    func authenticateUserAndConfigureUI() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        } else {
            fetchUser()
        }
    }
    
    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        UserService.shared.fetchUser(uid: uid) { user in
            self.user = user
        }
    }
    
    func configureLeftBarButton() {
        guard let user = user else { return }
        
        let profileImageView = UIImageView()
        profileImageView.setDimensions(height: 32, width: 32)
        profileImageView.layer.cornerRadius = 32 / 2
        profileImageView.layer.masksToBounds = true
        profileImageView.isUserInteractionEnabled = true
        profileImageView.backgroundColor = .groupTableViewBackground
        
        //      let tap = UITapGestureRecognizer(target: self, action: #selector(handleProfileImageTap))
        //     profileImageView.addGestureRecognizer(tap)
        
        profileImageView.sd_setImage(with: user.profileImageUrl, completed: nil)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImageView)
        
    }
    
    

}
