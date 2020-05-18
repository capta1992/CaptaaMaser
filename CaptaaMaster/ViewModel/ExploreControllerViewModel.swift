//
//  ExploreControllerViewModel.swift
//  CaptaaMaster
//
//  Created by Falilatu Aroworade on 5/7/20.
//  Copyright © 2020 Lawson Falomo. All rights reserved.
//

import Foundation

enum ExploreFilterOptions: Int, CaseIterable {
    case music
    case categories
    case featured
    
    
    var description: String {
        switch self {
        case.music: return "Music"
        case.categories: return "Categories"
        case.featured: return "Featured"
     
        }
    }
}
