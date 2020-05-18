//
//  Activity.swift
//  CaptaaMaster
//
//  Created by Falilatu Aroworade on 5/12/20.
//  Copyright © 2020 Lawson Falomo. All rights reserved.
//
import Foundation

enum NotificationType: Int {
    case follow
    case like
}

struct Notification {
    var captionID: String?
    var timestamp: Date!
    var user: User
    var caption: Caption?
    var type: NotificationType!
    
    init(user: User, dictionary: [String: AnyObject]) {
        self.user = user
                
        if let captionID = dictionary["captionID"] as? String {
            self.captionID = captionID
        }
        
        if let timestamp = dictionary["timestamp"] as? Double {
            self.timestamp = Date(timeIntervalSince1970: timestamp)
        }
        
        if let type = dictionary["type"] as? Int {
            self.type = NotificationType(rawValue: type)
        }
    }
}
