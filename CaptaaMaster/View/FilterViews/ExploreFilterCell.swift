//
//  ControlFilterCell.swift
//  CaptaaMaster
//
//  Created by Falilatu Aroworade on 5/7/20.
//  Copyright © 2020 Lawson Falomo. All rights reserved.
//

import UIKit

class ExploreFilterCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    var option: ExploreFilterOptions! {
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
    
    
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        addSubview(titleLabel)
        titleLabel.center(inView: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
