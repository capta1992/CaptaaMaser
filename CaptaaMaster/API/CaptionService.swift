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
    
    func uploadCaption(caption: String, hashtag: String, completion: @escaping(Error?, DatabaseReference) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        let values = ["uid": uid,
                      "timestamp": Int(NSDate().timeIntervalSince1970),
                      "likes": 0,
                      "copies": 0,
                      "hashtag": hashtag,
                      "caption": caption] as [String : Any]
        
        let ref = REF_CAPTIONS.childByAutoId()
        
        
        
        ref.updateChildValues(values) { (err, ref) in
            guard let captionID = ref.key else { return}
            REF_USER_CAPTIONS.child(uid).updateChildValues([captionID: 1], withCompletionBlock: completion)
            
        }
    }
    
 
    
    
    
    func fetchCaptions(completion: @escaping([Caption]) -> Void) {
        var captions = [Caption]()
        
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        REF_USER_FOLLOWING.child(currentUid).observe(.childAdded) { (snapshot) in
            let folloingUid = snapshot.key
            
            REF_USER_CAPTIONS.child(folloingUid).observe(.childAdded) { (snapshot) in
                let captionId = snapshot.key
                
                self.fetchCaption(withCaptionID: captionId) { (caption) in
                    captions.append(caption)
                    completion(captions)
                    
                }
            }
        }
        
        REF_USER_CAPTIONS.child(currentUid).observe(.childAdded) { (snapshot) in
            let captionId = snapshot.key
            self.fetchCaption(withCaptionID: captionId) { (caption) in
                captions.append(caption)
                completion(captions)
                
            }
        }
    }
    
    
    func fetchCaptions(forUser user: User, completion: @escaping([Caption]) -> Void) {
        
        var captions = [Caption]()
        
        REF_USER_CAPTIONS.child(user.uid!).observe(.childAdded) { (snapshot) in
            let captionID = snapshot.key
            
            
            self.fetchCaption(withCaptionID: captionID) { (caption) in
                captions.append(caption)
                completion(captions)
                
            }
        }
    }
    
    func fetchCaption(withCaptionID captionID: String, completion: @escaping (Caption) -> Void) {
        REF_CAPTIONS.child(captionID).observeSingleEvent(of: .value) { (snapshot) in
            guard let dictionary = snapshot.value as? [String: Any] else {return}
            guard let uid = dictionary["uid"] as? String else {return}
            
            UserService.shared.fetchUser(uid: uid) { (user) in
                let caption = Caption(user: user, captionID: captionID, dictionary: dictionary)
                completion(caption)
            }
            
        }
        
    }
    
    func fetchLikes(forUser user: User, completion: @escaping([Caption]) -> Void) {
        var captions = [Caption]()
        
        REF_USER_LIKES.child(user.uid ?? "nil").observe(.childAdded) { snapshot in
            let captionID = snapshot.key
            self.fetchCaption(withCaptionID: captionID) { (likedCaption) in
                var caption = likedCaption
                caption.didLike = true
                captions.append(caption)
                completion(captions)
            }
        }
    }
    
      
    
    
    func likeCaption(caption: Caption, completion: @escaping(DatabaseCompletion)) {
        guard let uid = Auth.auth().currentUser?.uid else { return}
        
        let likes = caption.didLike ? caption.likes - 1 : caption.likes + 1
        REF_CAPTIONS.child(caption.captionID).child("likes").setValue(likes)
        
        if caption.didLike {
            REF_USER_LIKES.child(uid).child(caption.captionID).removeValue { (err, ref) in
                REF_CAPTION_LIKES.child(caption.captionID).removeValue(completionBlock: completion)
            }
        } else {
            
            REF_USER_LIKES.child(uid).updateChildValues([caption.captionID: 1]) { (err, ref) in
                REF_CAPTION_LIKES.child(caption.captionID).updateChildValues([uid: 1], withCompletionBlock: completion)
            }
        }
    }
    func checkIfUserLikedCaption(_ caption: Caption, completion: @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return}
        
        REF_USER_LIKES.child(uid).child(caption.captionID).observeSingleEvent(of: .value) { (snapshot) in
            completion(snapshot.exists())
        }
    }
}


