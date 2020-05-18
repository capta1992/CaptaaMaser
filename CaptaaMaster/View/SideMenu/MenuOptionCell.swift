//
//  MenuOptionCell.swift
//  CaptaaMaster
//
//  Created by Falilatu Aroworade on 5/11/20.
//  Copyright © 2020 Lawson Falomo. All rights reserved.
//

import UIKit

class MenuOptionCell: UITableViewCell {
    
    // MARK: - Properties
    
    var option: MenuOptions? {
        didSet {
            iconImageView.image = option?.image
            descriptionLabel.text = option?.description
        }
    }
    
    let iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "AvenirNext-Bold", size: 14)
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .instagramColor
        selectionStyle = .none
        
        addSubview(iconImageView)
        iconImageView.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 8, constant: 0)
        iconImageView.setDimensions(height: 26, width: 26)
        
        addSubview(descriptionLabel)
        descriptionLabel.centerY(inView: self, leftAnchor: iconImageView.rightAnchor, paddingLeft: 16, constant: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
