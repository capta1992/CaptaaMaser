//
//  MusicProfileHeaderViewModel.swift
//  CaptaaMaster
//
//  Created by Falilatu Aroworade on 5/9/20.
//  Copyright © 2020 Lawson Falomo. All rights reserved.
//

import UIKit
import Firebase




struct MusicProfileHeaderViewModel {
 
    
    
    private let user: User
    
    
    let fullnametext: String
    
    var followingString: NSAttributedString? {
        return attributedText(withValue: user.stats?.following ?? 0, text: "Following", valueColor: .lightGray, textColor: .black)
        
    }
    
    var followersString: NSAttributedString {
        return attributedText(withValue: user.stats?.followers ?? 0, text: "Followers", valueColor: .lightGray, textColor: .black)
    }
    
    
      var actionButtonTitle: String {
        if user.isCurrentUser {
            return "Edit Profile"
        }
        
        if !user.isFollowed {
            return "Follow"
        }
        
        if user.isFollowed {
            return "Following"
        }
        
        return "Loading"
    }

    
    
    init(user:User) {
        self.user = user
        
        
        
        self.fullnametext = "@" + user.fullname!
    }
    
    
    fileprivate func  attributedText(withValue value: Int, text: String, valueColor: UIColor, textColor: UIColor) -> NSAttributedString {
        let attributedTitle = NSMutableAttributedString(string: "\(value)\n", attributes: [NSAttributedString.Key.font: UIFont(name: "AvenirNext-Bold", size: 18)!])
        attributedTitle.append(NSAttributedString(string: "Followers", attributes: [NSAttributedString.Key.font: UIFont(name: "AvenirNext-Medium", size: 12)!, NSAttributedString.Key.foregroundColor: UIColor.lightGray]))
        
        
        return attributedTitle
        //  label.attributedText = attributedText
        
    }
    
}

