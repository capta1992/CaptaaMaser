//
//  AppUserDefaults.swift
//  CaptaaMaster
//
//  Created by Falilatu Aroworade on 5/7/20.
//  Copyright © 2020 Lawson Falomo. All rights reserved.
//

import Foundation


enum OnboardKeys : String {
    case watchedHomeFeedInstructions
    case watchedArtistInsructions
}

extension UserDefaults {
    
func setWatchedInstructions(for defaultKey: OnboardKeys) {
    return set(true, forKey: defaultKey.rawValue)
}

func setUnwatchedInstructions(for defaultKey: OnboardKeys) {
    return set(false, forKey: defaultKey.rawValue)
}

func grabWatchedStatus(for defaultKey: OnboardKeys) -> Bool {
    return bool(forKey: defaultKey.rawValue)
}
    
}
