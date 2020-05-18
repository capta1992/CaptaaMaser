//
//  Caption.swift
//  CaptaaMaster
//
//  Created by Falilatu Aroworade on 5/2/20.
//  Copyright © 2020 Lawson Falomo. All rights reserved.
//

import Foundation

struct Caption {
    let caption: String
    let hashtag: String
    let captionID: String
    var likes: Int
    var timestamp: Date!
    let recaptionCount: Int
    var user: User
    var didLike = false
    
    
    init(user: User, captionID: String, dictionary: [String: Any]) {
        self.captionID = captionID
        self.user = user
        
        self.caption = dictionary["caption"] as? String ?? ""
        self.hashtag = dictionary["hashtag"] as? String ?? ""
        self.likes = dictionary["likes"] as? Int ?? 0
        self.recaptionCount = dictionary["recaptions"] as? Int ?? 0
        
        if let timestamp = dictionary["timestamp"] as? Double {
            self.timestamp = Date(timeIntervalSince1970: timestamp)
        }
    }
    
}
