//
//  FeedController.swift
//  CaptaaMaster
//
//  Created by Falilatu Aroworade on 4/29/20.
//  Copyright © 2020 Lawson Falomo. All rights reserved.
//

import UIKit

class FeedController: UIViewController {
    
    // MARK: - Properties
    
    private let logoImageView: UIImageView  = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "captaalogo")
        view.setDimensions(height: 30, width: 30)
        return view
    }()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
        
        
    }
    
    // MARK: - Selectors
    
    
    // MARK: - Helpers
    
    func configureUI(){
        view.backgroundColor = .white
        let imageView = logoImageView
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
    
    }
    
}
