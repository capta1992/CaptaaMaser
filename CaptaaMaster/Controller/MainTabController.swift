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
    
    // Properties
    
    var user: User? {
        didSet {
            guard let controller = viewControllers?[0] as? FeedController else { return }
            controller.user = user
        }
    }
    
    
    
    
    
    
    
    // MARK: - Lefecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    
    // MARK: - Helpers
    
    func configureUI() {
        //     logUserOut()
        view.backgroundColor = .backgroundColor
        //     configureViewControllers()
        
    }
    
   
    
    
    func logUserOut() {
        do {
            try Auth.auth().signOut()
        } catch let error {
            print("DEBUG: Failed to sign out with \(error.localizedDescription)")
        }
    }
    
    
    func configureViewControllers() {
        
        let feed = FeedController()
        let nav1 = templateNavigationController(image:  UIImage(named: "house"), rootViewController: feed)
        
        let explore = ExploreController()
        let nav2 = templateNavigationController(image: UIImage(named: "magnifyingglass.circle"), rootViewController: explore)
        
        let profile = ProfileController(collectionViewLayout: UICollectionViewFlowLayout())
        let nav3 = templateNavigationController(image: UIImage(named: "person.circle"), rootViewController: profile)
        
        let activity = ScheduleController()
        let nav4 = templateNavigationController(image: UIImage(named: "calendarb"), rootViewController: activity)
        
        let captionGenerator = CaptionGeneratorController()
        let nav5 = templateNavigationController(image: UIImage(named: "camera.viewfinder"), rootViewController: captionGenerator)
        
        
        viewControllers = [nav1,nav2,nav3,nav4,nav5]
    }
    
    func templateNavigationController(image: UIImage?, rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = image
        nav.navigationBar.barTintColor = .white
        return nav
    }
}
