//
//  ExploreController.swift
//  CaptaaMaster
//
//  Created by Falilatu Aroworade on 4/29/20.
//  Copyright © 2020 Lawson Falomo. All rights reserved.
//

import UIKit

class ExploreController: UIViewController {
    
    // MARK: - Properties
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
        
        
    }
    
    // MARK: - Selectors
    
    
    // MARK: - Helpers
    
    func configureUI(){
        view.backgroundColor = .white
        navigationItem.title = "Explore"
    }
    
}
