//
//  ActionSheetCell.swift
//  CaptaaMaster
//
//  Created by Falilatu Aroworade on 5/11/20.
//  Copyright © 2020 Lawson Falomo. All rights reserved.
//

import UIKit

class ActionSheetCell: UITableViewCell {
    
    // MARK: - Properties
    
    var option: ActionSheetOptions? {
        didSet { configure()}
    }
    
    private let optionImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "captaalogo")
        iv.setDimensions(height: 15, width: 15)
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AvenirNext-Medium", size: 15)
        label.text = "Test Option"
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(optionImageView)
        optionImageView.centerY(inView: self)
        optionImageView.anchor(left: leftAnchor, paddingLeft: 8)
        optionImageView.setDimensions(height: 36, width: 36)
        
        addSubview(titleLabel)
        titleLabel.centerY(inView: self)
        titleLabel.anchor(left: optionImageView.rightAnchor, paddingLeft: 12)
        
        
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configure() {
        titleLabel.text = option?.description
    }
    
}
