//
//  User.swift
//  InstagramCloneTutorial
//
//  Created by Denis Makarau on 19.08.25.
//

import Foundation
import FirebaseAuth

struct User: Identifiable, Codable, Hashable {
    let id: String
    var username: String
    var profileImageUrl: String?
    var fullname: String?
    var bio: String?
    let email: String
    
    var isFollowed: Bool? = false
    var stats: UserStats?
    
    var isCurrentUser: Bool {
        guard let currentUid = Auth.auth().currentUser?.uid else { return false }
        return currentUid == id
    }
}

struct UserStats: Codable, Hashable {
    var followingCount: Int
    var followersCount: Int
    var postsCount: Int
}

extension User {
    static var MOCK_USERS: [User] = [
        .init(
            id: NSUUID().uuidString,
            username: "batman",
            profileImageUrl: nil, fullname: "Bruce Wayne",
            bio: "Gotham's Dark Knight", email: "batman@gmail.com"
        ),
        .init(
            id: NSUUID().uuidString,
            username: "venom",
            profileImageUrl: "venom", fullname: "Eddie Brock",
            bio: "Venom, symbiote, rage", email: "venom@gmail.com"
        ),
        .init(
            id: NSUUID().uuidString,
            username: "ironman",
            profileImageUrl: "ironman", fullname: "Tony Stark",
            bio: "Playboy & Billionaire", email: "ironman@gmail.com"
        ),
        .init(
            id: NSUUID().uuidString,
            username: "blackpanther",
            profileImageUrl: "black-panther-1", fullname: nil,
            bio: "Gotham's Dark Knight", email: "blackpanther@gmail.com"
        ),
        .init(
            id: NSUUID().uuidString,
            username: "spiderman",
            profileImageUrl: "spiderman", fullname: "Peter Parker",
            bio: "Spider-Man", email: "spiderman@gmail.com"
        ),
    ]
}
