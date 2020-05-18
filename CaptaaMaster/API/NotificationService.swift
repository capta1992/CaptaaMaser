//
//  NotificationService.swift
//  CaptaaMaster
//
//  Created by Falilatu Aroworade on 5/12/20.
//  Copyright © 2020 Lawson Falomo. All rights reserved.
//

import Firebase

struct NotificationService {
    static let shared = NotificationService()
    
    func uploadNotification(type: NotificationType, caption: Caption? = nil, user: User? = nil) {
        guard let uid = Auth.auth().currentUser?.uid else { return}
        
        var values: [String: Any] = ["timestamp": Int(NSDate().timeIntervalSince1970),
                                     "uid": uid,
                                     "type": type.rawValue]
        
        if let caption = caption {
            values["captionID"] = caption.captionID
         REF_NOTIFICATIONS.child(caption.user.uid ?? "nil").childByAutoId().updateChildValues(values)
            
        } else if let user = user{
            REF_NOTIFICATIONS.child(user.uid ?? "nil").childByAutoId().updateChildValues(values)
        }
        
    }
    
    func fetchNotifications(completion: @escaping([Notification]) -> Void) {
        var notifications = [Notification]()
        guard let uid = Auth.auth().currentUser?.uid else { return}
        
        REF_NOTIFICATIONS.child(uid).observe(.childAdded) { (snapshot) in
            guard let dictionary = snapshot.value as? [String: AnyObject] else { return}
            guard let uid = dictionary["uid"] as? String else { return}
            
            UserService.shared.fetchUser(uid: uid) { (user) in
                let notification = Notification(user: user, dictionary: dictionary)
                notifications.append(notification)
                completion(notifications)
            }
            
            
        }
    }
}

