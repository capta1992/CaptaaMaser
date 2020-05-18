//
//  HomeHeaderViewModel.swift
//  CaptaaMaster
//
//  Created by Falilatu Aroworade on 5/9/20.
//  Copyright © 2020 Lawson Falomo. All rights reserved.
//

import Foundation

enum HomeFilterOptions: Int, CaseIterable {
    case foryou
    case trending
    case hashtags
    
    var description: String {
        switch self {
        case.foryou: return "For You"
        case.trending: return "Trending"
        case.hashtags: return "Hashtags"
        }
    }
    
}
