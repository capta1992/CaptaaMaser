//
//  CaptionViewModel.swift
//  CaptaaMaster
//
//  Created by Falilatu Aroworade on 5/3/20.
//  Copyright © 2020 Lawson Falomo. All rights reserved.
//

import UIKit

struct CaptionViewModel {
    
    let caption: Caption
    let user: User
    
    var profileImageUrl: URL? {
        return user.profileImageUrl
    }
    
    var timeStamp: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .abbreviated
        let now = Date()
        return formatter.string(from: caption.timestamp, to: now) ?? "2m"
    }
    
    var userInfoText: NSAttributedString {
        let title = NSMutableAttributedString(string: user.fullname!, attributes: [.font: UIFont.boldSystemFont(ofSize: 12)])
        
        
        
        return title
        
        
        
        
    }
    
    init(caption: Caption) {
        self.caption = caption
        self.user = caption.user
    }
    
    
}
