//
//  User.swift
//  CaptaaMaster
//
//  Created by Falilatu Aroworade on 4/29/20.
//  Copyright © 2020 Lawson Falomo. All rights reserved.
//

import Foundation
import Firebase

struct User {
    
    var fullname: String?
    let email: String?
    var profileImageUrl: URL?
    let uid: String?
    var isFollowed = false
    let accountType: Int?
    var stats: UserRelationStats?
    var bio: String?
    var isCurrentUser: Bool { return Auth.auth().currentUser?.uid == uid}
    
    
    init(uid: String, dictionary: [String: AnyObject]) {
        self.uid = uid
        
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.accountType = dictionary["accountType"] as? Int ?? 0
        
        if let bio = dictionary["bio"] as? String {
            self.bio = bio
        }
        
        
        if let profileImageUrlString = dictionary["profileImageUrl"] as? String {
            guard let url = URL(string: profileImageUrlString) else { return }
            self.profileImageUrl = url
        }
    }
}

struct UserRelationStats {
    var followers: Int
    var following: Int
}
