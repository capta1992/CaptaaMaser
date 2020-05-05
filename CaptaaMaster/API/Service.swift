//
//  Service.swift
//  CaptaaMaster
//
//  Created by Falilatu Aroworade on 4/29/20.
//  Copyright © 2020 Lawson Falomo. All rights reserved.
//

import Firebase
import GoogleSignIn

typealias DatabaseCompletion = ((Error?, DatabaseReference) -> Void)

struct Service {
    
    static func logUserIn(withEmail email: String, password: String, completion: AuthDataResultCallback?) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    static func registerUserWithFirebase(withEmail email: String, password: String, fullname: String, completion: @escaping(DatabaseCompletion)) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                completion(error, REF_USERS)
                return
            }
            
            guard let uid = result?.user.uid else {return}
            let values = ["email": email, "fullname": fullname, "hasSeenOnboarding": false] as [String : Any]
            
            REF_USERS.child(uid).updateChildValues(values, withCompletionBlock: completion)
            
        }
    }
    
    
    
    static func signInWithGoogle(didSignInFor user: GIDGoogleUser, completion: @escaping (DatabaseCompletion)) {
        guard let authentication = user.authentication else {return}
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        
        Auth.auth().signIn(with: credential) { (result, error) in
            if let error = error {
                print("DEBUG: Failed to sign user in with google  \(error.localizedDescription)")
                completion(error, REF_USERS)
                return
            }
            
            guard let uid = result?.user.uid else {return}
          
            
            REF_USERS.child(uid).observeSingleEvent(of: .value) { (snapshot) in
                if !snapshot.exists() {
                    print("DEBUG: user does not exist")
                    guard let email = result?.user.email else {return}
                    guard let fullname = result?.user.displayName else {return}
                    
                    
                    let values = ["email": email, "fullname": fullname, "hasSeenOnboarding": false] as [String : Any]
                    REF_USERS.child(uid).updateChildValues(values, withCompletionBlock: completion)
                } else {
                    print("DEBUG: user already exists")
                    completion(error, REF_USERS.child(uid))
                }
            }
        }
        
    }
    
  
  
    
    static func resetPassword(forEmail email: String,completion: SendPasswordResetCallback?) {
        Auth.auth().sendPasswordReset(withEmail: email, completion: completion)
    }
    
}
