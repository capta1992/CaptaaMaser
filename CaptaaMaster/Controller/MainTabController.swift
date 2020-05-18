//
//  MainTabController.swift
//  CaptaaMaster
//
//  Created by Falilatu Aroworade on 4/29/20.
//  Copyright © 2020 Lawson Falomo. All rights reserved.
//

import UIKit
import Firebase

class MainTabController: UITabBarController, UITabBarControllerDelegate {
    
    // Properties
    
     var feedController: FeedController?
    
    
    
    let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.backgroundColor = .twitterBlue
        button.setImage(UIImage(named: "new_tweet"), for: .normal)
        button.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let dot = UIView()
    
    
    
     var user: User? {
          didSet {
              guard let controller = viewControllers?[0] as? ContainerController else { return }
              controller.user = user
          }
      }
      
    
    // MARK: - Lefecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authenticateUserAndConfigureUI()
        configureNotificationDot()
        
        
        
    }
    
    
    // MARK: - API
    
    func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        UserService.shared.fetchUser(uid: uid) { user in
            self.user = user
        }
    }
    
    
    func authenticateUserAndConfigureUI() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        } else {
            configureViewControllers()
            configureUI()
            fetchUser()
            
        }
    }
    
    // MARK: - Selectors
    
    @objc func actionButtonTapped() {
        guard let user = user else {return}
        let nav = UINavigationController(rootViewController: UploadCaptionController(user: user))
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        
        self.delegate = self
        
      // logUserOut()
        view.backgroundColor = .backgroundColor
        
        view.addSubview(actionButton)
        actionButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingBottom: 64, paddingRight: 16, width: 56, height: 56)
        
        actionButton.layer.cornerRadius = 56 / 2
        
        
    }
    
    
    func logUserOut() {
        do {
            try Auth.auth().signOut()
        } catch let error {
            print("DEBUG: Failed to sign out with \(error.localizedDescription)")
        }
    }
    
    
    func configureViewControllers() {
        
        let feedContainer = ContainerController()
        feedContainer.tabBarItem.image = #imageLiteral(resourceName: "home_unselected")
      
        let explore = ExploreController()
        let nav2 = templateNavigationController(image: UIImage(named: "magnifyingglass.circle"), rootViewController: explore)
        
        let profile = ProfileController(collectionViewLayout: UICollectionViewFlowLayout())
        let nav3 = templateNavigationController(image: UIImage(named: "person.circle"), rootViewController: profile)
        
     //   let activity = ScheduleController()
     //   let nav4 = templateNavigationController(image: UIImage(named: "calendarb"), rootViewController: activity)
        
        let captionGenerator = CaptionGeneratorController()
        let nav4 = templateNavigationController(image: UIImage(named: "camera.viewfinder"), rootViewController: captionGenerator)
        
        
        viewControllers = [feedContainer,nav2,nav3,nav4]
    }
    

    func templateNavigationController(image: UIImage?, rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = image
        nav.navigationBar.barTintColor = .white
        return nav
    }
    
    
    
    func configureNotificationDot() {
        if UIDevice().userInterfaceIdiom == .phone {
       //     let tabBarHeight = tabBar.frame.height
            
            dot.backgroundColor  = #colorLiteral(red: 1, green: 0, blue: 0.3288334012, alpha: 1)
            
            dot.translatesAutoresizingMaskIntoConstraints = false
            dot.layer.cornerRadius = dot.frame.width / 2
            tabBar.addSubview(dot)
            if let item = tabBar.items?[0].value(forKey: "view") as? UIView {
                print("View EXIST")
                dot.layer.cornerRadius = 3
                dot.anchor(top: item.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: -10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 6, height: 6)
                dot.centerXAnchor.constraint(equalTo: item.centerXAnchor).isActive = true
            }
            
            dot.isHidden = false
            
        }
    }
    
    
    
    
}
