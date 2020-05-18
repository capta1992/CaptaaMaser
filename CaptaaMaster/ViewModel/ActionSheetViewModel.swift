//
//  ActionSheetViewModel.swift
//  CaptaaMaster
//
//  Created by Falilatu Aroworade on 5/11/20.
//  Copyright © 2020 Lawson Falomo. All rights reserved.
//

import Foundation

struct ActionSheetViewModel {
    
    private let user: User
    
    var option: [ActionSheetOptions] {
        var results = [ActionSheetOptions]()
        
        if user.isCurrentUser {
            results.append(.delete)
        } else {
            let followOption: ActionSheetOptions = user.isFollowed ? .unfollow(user) : .follow(user)
            results.append(followOption)
        }
        
        results.append(.report)
        
        return results
    }
    
    init(user: User) {
        self.user = user
        
    }
}

enum ActionSheetOptions {
    case follow(User)
    case unfollow(User)
    case report
    case delete
    
    var description: String {
        switch self {
            
        case .follow(let user): return "Follow @\(user.fullname ?? "nil")"
        case .unfollow(let user): return "Unfollow @\(user.fullname ?? "nil")"
        case .report: return "Report Tweet"
        case .delete: return "Delete Caption"
        }
    }
}
