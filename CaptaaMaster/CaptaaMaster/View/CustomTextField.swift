//
//  CustomTextField.swift
//  CaptaaMaster
//
//  Created by Falilatu Aroworade on 4/28/20.
//  Copyright © 2020 Lawson Falomo. All rights reserved.
//

import UIKit

class CustomTexttField: UITextField {
    init(placeHolder: String) {
        super.init(frame: .zero)
        
        let spacer = UIView()
        spacer.setDimensions(height: 50, width: 12)
        leftView = spacer
        leftViewMode = .always
        
        borderStyle = .none
        textColor = .white
        keyboardAppearance = .dark
        backgroundColor = UIColor(white: 1, alpha: 0.1)
        setHeight(height: 50)
        attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [.foregroundColor: UIColor(white: 1.0, alpha: 0.7)])
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



