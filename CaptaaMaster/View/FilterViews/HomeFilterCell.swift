//
//  HomeFilterCell.swift
//  CaptaaMaster
//
//  Created by Falilatu Aroworade on 5/9/20.
//  Copyright © 2020 Lawson Falomo. All rights reserved.
//

import UIKit

class HomeFilterCell: UICollectionViewCell {
    
    // MARK: - Properties
    
       var option: HomeFilterOptions! {
         didSet { titleLabel.text = option.description}
     }
    
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Test filter"
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            titleLabel.font = isSelected ? UIFont(name: "AvenirNext-Bold", size: 14) : UIFont(name: "AvenirNext-Medium", size: 13)
            
            titleLabel.textColor = isSelected ? .twitterBlue : .lightGray
        }
    }
    
    
    
    // MARK: - Lifecylce
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        addSubview(titleLabel)
        titleLabel.center(inView: self)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Selectors
    
    // MARK: - Helpers
    
}
