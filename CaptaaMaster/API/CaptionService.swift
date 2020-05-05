//
//  CaptionService.swift
//  CaptaaMaster
//
//  Created by Falilatu Aroworade on 5/2/20.
//  Copyright © 2020 Lawson Falomo. All rights reserved.
//

import UIKit
import Firebase

struct CaptionService {
    static let shared = CaptionService()
    
    func uploadCaption(caption: String, completion: @escaping(Error?, DatabaseReference) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        let values = ["uid": uid, "timestamp": Int(NSDate().timeIntervalSince1970), "copy": 0, "caption": caption] as [String : Any]
        
        REF_SAVED_CAPTIONS.childByAutoId().updateChildValues(values, withCompletionBlock: completion)
        print("DEBUG: will come back to later")
    }
    
    func fetchSavedCaptions(completion: @escaping([Caption]) -> Void) {
        var captions = [Caption]()
        
        REF_SAVED_CAPTIONS.observe(.childAdded) { (snapshot) in
            guard let dictionary = snapshot.value as? [String: Any] else {return}
            guard let uid = dictionary["uid"] as? String else {return}
            let captionID = snapshot.key
            
            UserService.shared.fetchUser(uid: uid) { (user) in
                let caption = Caption(user: user, captionID: captionID, dictionary: dictionary)
                captions.append(caption)
                completion(captions)
            }
        }
    }
    
}


