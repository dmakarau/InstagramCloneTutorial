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
}
