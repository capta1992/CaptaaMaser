//
//  CoachMarks.swift
//  CaptaaMaster
//
//  Created by Falilatu Aroworade on 5/7/20.
//  Copyright © 2020 Lawson Falomo. All rights reserved.
//


import Foundation

struct CoachMarks {
    struct HomeFeed {
        struct Feed {
            static  var title = "Welcome to Captaa"
            static var instructions = "This is the home feed, scroll and find the best caption for you"
        }
        struct CopyExport {
            static var title = "Find a caption you like?"
            static var instructions = "Copy the text, or export the\ncomplete photo to\nyour instagram"
            
        }
        
        struct Like {
            static  var title = "Want to save if for later?"
            static var instructions = "Like the caption & view it when you'd like in your profile."
        }
        
        struct mood {
            static  var title = "Looking for a a certain mood?"
            static var instructions = "Click any for a related list of caption"
        }
        
    }
    
    struct ArtistSection {
        struct ArtistCell {
            static var title = "Maybe some lyric captions?"
            static var instructions = "Click on any artist to \nview a feed of captions, based\non their song lyrics"
        }
    }
    
}
