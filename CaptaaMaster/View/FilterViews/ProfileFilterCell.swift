//
//  ProfileFilterCell.swift
//  CaptaaMaster
//
//  Created by Falilatu Aroworade on 5/15/20.
//  Copyright © 2020 Lawson Falomo. All rights reserved.
//

import UIKit

class ProfileFilterCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    var option: ProfileFilterOptions! {
        didSet { titleLabel.text = option.description}
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont(name: "AvenirNext-Medium", size: 12)
        label.text = "Test filter"
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            titleLabel.font = isSelected ? UIFont(name: "AvenirNext-Bold", size: 13) :
                UIFont(name: "AvenirNext-Medium", size: 12)
            titleLabel.textColor = isSelected ? .instagramColor : .lightGray
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
