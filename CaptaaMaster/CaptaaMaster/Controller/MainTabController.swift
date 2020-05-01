//
//  MainTabController.swift
//  CaptaaMaster
//
//  Created by Falilatu Aroworade on 4/29/20.
//  Copyright © 2020 Lawson Falomo. All rights reserved.
//

import UIKit

class MainTabController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .backgroundColor
        
        configureViewControllers()

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
    
        func templateNavigationController(image: UIImage?, rootViewController: UIViewController) -> UINavigationController {
            let nav = UINavigationController(rootViewController: rootViewController)
            nav.tabBarItem.image = image
            nav.navigationBar.barTintColor = .white
            return nav
        }
    }
    

