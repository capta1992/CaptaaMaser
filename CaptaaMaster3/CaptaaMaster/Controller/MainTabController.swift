//
//  MainTabController.swift
//  CaptaaMaster
//
//  Created by Falilatu Aroworade on 4/29/20.
//  Copyright © 2020 Lawson Falomo. All rights reserved.
//

import UIKit
import Firebase

class MainTabController: UITabBarController {
    
    // MARK: - Properties
    
    var user: User? {
        didSet {
            guard let nav = viewControllers?[0] as? UINavigationController else {return}
            guard let feed = nav.viewControllers.first as? FeedController else {return}
            
            feed.user = user
        }
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .backgroundColor
   //   logUserOut()
        authenticateUserAndConfigureUI()
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
    
    func logUserOut() {
        do {
            try Auth.auth().signOut()
        } catch let error {
            print("DEBUG: Failed to sign out with \(error.localizedDescription)")
        }
    }

    
    
    
    
    
    // MARK: - Helpers
    
    func configureViewControllers() {
        
        let feed = FeedController()
        let nav1 = templateNavigationController(image:  UIImage(named: "house"), rootViewController: feed)
        
        let explore = ExploreController()
        let nav2 = templateNavigationController(image: UIImage(named: "magnifyingglass.circle"), rootViewController: explore)
        
        let profile = ProfileController()
        let nav3 = templateNavigationController(image: UIImage(named: "person.circle"), rootViewController: profile)
        
         let activity = ActivityController()
        let nav4 = templateNavigationController(image: UIImage(named: "heart.circle"), rootViewController: activity)
        
        let captionGenerator = CaptionGeneratorController()
        let nav5 = templateNavigationController(image: UIImage(named: "camera.viewfinder"), rootViewController: captionGenerator)
       
        
        viewControllers = [nav1,nav2,nav3,nav4,nav5]
    }

    
    
    func configureUI() {
        view.backgroundColor = .backgroundColor
    }
    
  
    
        func templateNavigationController(image: UIImage?, rootViewController: UIViewController) -> UINavigationController {
            let nav = UINavigationController(rootViewController: rootViewController)
            nav.tabBarItem.image = image
            nav.navigationBar.barTintColor = .white
            return nav
        }
    }
