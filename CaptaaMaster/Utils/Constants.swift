//
//  Constants.swift
//  CaptaaMaster
//
//  Created by Falilatu Aroworade on 4/29/20.
//  Copyright © 2020 Lawson Falomo. All rights reserved.
//

import Firebase
import FirebaseDatabase

// MARK: - Root References

let DB_REF = Database.database().reference()
let STORAGE_REF = Storage.storage().reference()
let STORAGE_PROFILE_IMAGES = STORAGE_REF.child("profile_images")

// MARK: - Storage References

let STORAGE_PROFILE_IMAGES_REF = STORAGE_REF.child("profile_images")
let STORAGE_POST_IMAGES_REF = STORAGE_REF.child("post_images")


// MARK: - Database References

let REF_USER_USERNAMES = DB_REF.child("user-usernames")
let USER_CAPTA_REF = DB_REF.child("capta-user")
let USER_EMOJI_REF = DB_REF.child("emoji-user")
let USER_MUSIC_REF = DB_REF.child("music-user")
let USER_FOLLOWER_REF = DB_REF.child("user-followers")
let USER_FOLLOWING_REF = DB_REF.child("user-following")
let CAPTA_FOLLOWING_REF = DB_REF.child("capta-following")
let POSTS_REF = DB_REF.child("posts")
let BLOCKED_USER_REF = DB_REF.child("blocked-users")
let CAPTA_POSTS_REF = DB_REF.child("capta-posts")
let USER_POSTS_REF = DB_REF.child("user-posts")
let USER_FEED_REF = DB_REF.child("user-feed")
let USER_LIKES_REF = DB_REF.child("user-likes")
let POST_LIKES_REF = DB_REF.child("post-likes")
let CAPTA_LIKES_REF = DB_REF.child("capta-likes")
let COMMENT_REF = DB_REF.child("comments")
let MESSAGES_REF = DB_REF.child("messages")
let USER_MESSAGES_REF = DB_REF.child("user-messages")
let HASHTAG_POST_REF = DB_REF.child("hashtag-post")
let SAVE_POST_REF = DB_REF.child("saved-posts")


let REF_USERS = DB_REF.child("users")
let REF_CAPTIONS = DB_REF.child("captions")
let REF_USER_CAPTIONS = DB_REF.child("user-captions")
let REF_USER_FOLLOWERS = DB_REF.child("user-followers")
let REF_USER_FOLLOWING = DB_REF.child("user-following")
let REF_USER_LIKES = DB_REF.child("user-likes")
let REF_CAPTION_LIKES = DB_REF.child("caption-likes")
let REF_NOTIFICATIONS = DB_REF.child("notifications")
let REF_CATEGORY_USERS = DB_REF.child("categories")
let REF_MUSIC_USERS = DB_REF.child("music")
let REF_FEATURED_USERS = DB_REF.child("featured")
let REF_HASHTAG_POST = DB_REF.child("hashtag-post")






let MSG_RESET_PASSWORD_LINK_SENT = "We sent a link to your email to reset your password"



let LIKE_INT_VALUE = 0
