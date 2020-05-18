//
//  HashtagCell.swift
//  CaptaaMaster
//
//  Created by Falilatu Aroworade on 5/13/20.
//  Copyright © 2020 Lawson Falomo. All rights reserved.
//

import UIKit
import ActiveLabel

class HashtagCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    
    var caption: Caption? {
        didSet { configure()}
        
   }
    
    
    
    // Deseign tthis like caption cell so the users post populatte go ba
    
    lazy var captionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "AmaticSC-Regular", size: 14)

        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var postImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = UIColor.lightGray.withAlphaComponent(0.0)
        
        addSubview(self.captionLabel)
        self.captionLabel.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: -50)
        
        
        
        
        return iv
        
    }()

    
    
    
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        
      
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
    
    // MARK: - Helpers
    
       
     func configure() {
   
        
        addSubview(postImageView)
        postImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
        postImageView.backgroundColor = .lightGray
        
     
       captionLabel.text = caption?.caption
  
        
        
    }
    
    
           
}
