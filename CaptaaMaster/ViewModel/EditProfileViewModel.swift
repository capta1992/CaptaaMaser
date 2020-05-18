//
//  EditProfileViewModel.swift
//  CaptaaMaster
//
//  Created by Falilatu Aroworade on 5/14/20.
//  Copyright © 2020 Lawson Falomo. All rights reserved.
//

import Foundation

enum EditProfileOptions: Int, CaseIterable {
    case fullname
    case bio
    
    var description: String {
        switch self {
        case .fullname: return "Name"
       case .bio: return "Bio"
        }
    }
}

struct EditProfileViewModel {
    
    private let user: User
    let option: EditProfileOptions
    
    var titleText: String {
        return option.description
    }
    
    var optionValue: String? {
        switch option {
        case .fullname: return user.fullname
       case .bio: return user.bio
        }
    }
    
    var shouldHideTextField: Bool {
        return option == .bio
    }
    
    var shouldHideTextView: Bool {
        return option != .bio
    }
    
    var shouldHidePlaceholderLabel: Bool {
        return user.bio != nil
    }
    
    init(user: User, option: EditProfileOptions) {
        self.user = user
        self.option = option
    }
}
