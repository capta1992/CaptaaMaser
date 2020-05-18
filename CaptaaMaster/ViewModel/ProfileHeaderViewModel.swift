//
//  ProfileHeaderViewModel.swift
//  CaptaaMaster
//
//  Created by Falilatu Aroworade on 5/5/20.
//  Copyright © 2020 Lawson Falomo. All rights reserved.
//

import UIKit
import Firebase



enum ProfileFilterOptions: Int, CaseIterable {
    case savedCaptions
    case likedCaption
    case personal
    
    var description: String {
        switch self {
        case .savedCaptions: return "Saved Captions"
        case .likedCaption: return "Liked Captions"
        case .personal: return "Personal"
        }
    }
}





struct ProfileHeaderViewModel {
    private let user: User
    
    
    let fullnametext: String
    
    var followingString: NSAttributedString? {
        return attributedText(withValue: user.stats?.following ?? 0, text: "Following", valueColor: .lightGray, textColor: .black)
        
    }
    
    var followersString: NSAttributedString {
        return attributedText(withValue: user.stats?.followers ?? 0, text: "Followers", valueColor: .lightGray, textColor: .black)
    }
    
    var menuFollowingString: NSAttributedString {
        return menuAttributedText(withValue: user.stats?.following ?? 0, text: "Following", valueColor: .white, textColor: .white)
    }
    
    var actionButttonTitle: String {
        if user.isCurrentUser {
            return "Edit Profile"
        } else {
            return "Follow"
        }
    }
    
    
    
    init(user:User) {
        
        self.user = user
        
        self.fullnametext = "@" + user.fullname!
    }
    
    
    fileprivate func  attributedText(withValue value: Int, text: String, valueColor: UIColor, textColor: UIColor) -> NSAttributedString {
        let attributedTitle = NSMutableAttributedString(string: "\(value)\n", attributes: [NSAttributedString.Key.font: UIFont(name: "AvenirNext-Bold", size: 18)!])
        attributedTitle.append(NSAttributedString(string: "Following", attributes: [NSAttributedString.Key.font: UIFont(name: "AvenirNext-Medium", size: 12)!, NSAttributedString.Key.foregroundColor: UIColor.lightGray]))
        
        
        return attributedTitle
        //  label.attributedText = attributedText
        
    }
    
    
     fileprivate func menuAttributedText(withValue value: Int, text: String,
                                       valueColor: UIColor, textColor: UIColor) -> NSAttributedString {
           let attributedTitle = NSMutableAttributedString(string: "\(value)",
               attributes: [.font : UIFont.boldSystemFont(ofSize: 14), .foregroundColor: valueColor])
           
           attributedTitle.append(NSAttributedString(string: " \(text)",
                                                     attributes: [.font: UIFont.systemFont(ofSize: 14),
                                                                  .foregroundColor: textColor]))
           return attributedTitle
       }
    
    
    
    
}

