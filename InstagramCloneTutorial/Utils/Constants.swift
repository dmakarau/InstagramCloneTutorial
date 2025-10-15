//
//  Constants.swift
//  InstagramCloneTutorial
//
//  Created by Denis Makarau on 07.10.25.
//

import Foundation
import Firebase

struct FirebaseConstants {
    static let Root = Firestore.firestore()
    
    static let UsersCollection = Root.collection("users")
    
    static let PostsCollection = Root.collection("posts")
    
    static let FollowingCollection = Root.collection("following")
    static let FollowersCollection = Root.collection("followers")
    
    static let NotificationsCollection = Root.collection("notifications")
    
    static func UserNotificationCollection(uid: String) -> CollectionReference {
        return NotificationsCollection.document(uid).collection("user-notifications")
    }
}
