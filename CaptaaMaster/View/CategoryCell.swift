//
//  CategoryCell.swift
//  CaptaaMaster
//
//  Created by Falilatu Aroworade on 5/4/20.
//  Copyright © 2020 Lawson Falomo. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
    
    
    // MARK: - Helpers
    
    func configureUI() {
        backgroundColor = .twitterBlue
    }
    
    
}
