//
//  SeperatorView.swift
//  CaptaaMaster
//
//  Created by Falilatu Aroworade on 4/28/20.
//  Copyright © 2020 Lawson Falomo. All rights reserved.
//

import UIKit

class SeperatorView: UIView {
    
    // MARK: - Properties
    
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
       
     
        
        let divider1 = UIView()
        divider1.backgroundColor = UIColor(white: 1, alpha: 0.25)
        addSubview(divider1)
        divider1.centerY(inView: self)
        divider1.anchor(left: leftAnchor, right: rightAnchor, paddingLeft: 8, paddingRight: 8, height: 1.0)
        
   
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
