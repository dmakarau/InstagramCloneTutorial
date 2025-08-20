//
//  User.swift
//  InstagramCloneTutorial
//
//  Created by Denis Makarau on 19.08.25.
//

import Foundation

struct User: Identifiable, Codable, Hashable {
    let id: String
    var username: String
    var profileImageUrl: String?
    var fullName: String?
    var bio: String?
    let email: String
}

extension User {
    static var MOCK_USERS: [User] = [
        .init(
            id: NSUUID().uuidString,
            username: "batman",
            profileImageUrl: "batman", fullName: "Bruce Wayne",
            bio: "Gotham's Dark Knight", email: "batman@gmail.com"
        ),
        .init(
            id: NSUUID().uuidString,
            username: "venom",
            profileImageUrl: "venom", fullName: "Eddie Brock",
            bio: "Venom, symbiote, rage", email: "venom@gmail.com"
        ),
        .init(
            id: NSUUID().uuidString,
            username: "ironman",
            profileImageUrl: "ironman", fullName: "Tony Stark",
            bio: "Playboy & Billionaire", email: "ironman@gmail.com"
        ),
        .init(
            id: NSUUID().uuidString,
            username: "blackpanther",
            profileImageUrl: "black-panther-1", fullName: nil,
            bio: "Gotham's Dark Knight", email: "blackpanther@gmail.com"
        ),
        .init(
            id: NSUUID().uuidString,
            username: "spiderman",
            profileImageUrl: "spiderman", fullName: "Peter Parker",
            bio: "Spider-Man", email: "spiderman@gmail.com"
        ),
    ]
}
