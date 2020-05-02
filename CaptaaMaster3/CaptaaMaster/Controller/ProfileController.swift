//
//  ProfileController.swift
//  CaptaaMaster
//
//  Created by Falilatu Aroworade on 4/29/20.
//  Copyright © 2020 Lawson Falomo. All rights reserved.
//

import UIKit

class ProfileController: UIViewController {
    
    // MARK: - Properties
    
    var user: User? {
        didSet {return}
    }

    private lazy var actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.backgroundColor = .twitterBlue
        button.setImage(UIImage(named: "new_tweet"), for: .normal)
        button.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
        
        
    }
    
    // MARK: - Selectors
    
    @objc func actionButtonTapped() {
        guard let user = user else {return}
      let controller = UploadCaptionController(user: user)
        let nav = UINavigationController(rootViewController: controller)
        present(nav, animated: true, completion: nil)
    }
    
    
    
    // MARK: - Helpers
    
    func configureUI(){
        
        view.addSubview(actionButton)
        actionButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor,
                            paddingBottom: 30, paddingRight: 16, width: 56, height: 56)
        actionButton.layer.cornerRadius = 56 / 2
        
        
        
        view.backgroundColor = .white
        navigationItem.title = "Profile"  // Change to users name use original capta as reference
    }
    
}
