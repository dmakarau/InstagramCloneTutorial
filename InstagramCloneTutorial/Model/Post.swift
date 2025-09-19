//
//  Post.swift
//  InstagramCloneTutorial
//
//  Created by Denis Makarau on 21.08.25.
//

import Foundation
import Firebase

struct  Post: Identifiable, Hashable, Codable {
    let id: String
    let ownerId: String
    let caption: String
    var likes: Int
    let imageUrl: String
    let timestamp: Timestamp
    var user: User?
    
    var didLike: Bool? = false
}

extension Post {
    static let MOCK_IMAGE_URL =
    "https://firebasestorage.googleapis.com:443/v0/b/instagramswiftui-73142.firebasestorage.app/o/profileImages%2FACB2D887-30FD-439E-BDF5-65ECF14CF2D4?alt=media&token=dbae008f-3202-4966-8e6c-5ff68db3171b"
    
    static var MOCK_POSTS: [Post] = [
        .init(
            id: NSUUID().uuidString,
            ownerId: NSUUID().uuidString,
            caption: "This is some test caption for now",
            likes: 123,
            imageUrl: MOCK_IMAGE_URL,
            timestamp: Timestamp(),
            user: User.MOCK_USERS[0]
        ),
        .init(
            id: NSUUID().uuidString,
            ownerId: NSUUID().uuidString,
            caption: "Exploring the city lights!",
            likes: 87,
            imageUrl: "spiderman",
            timestamp: Timestamp(),
            user: User.MOCK_USERS[1]
        ),
        .init(
            id: NSUUID().uuidString,
            ownerId: NSUUID().uuidString,
            caption: "Suit up for the mission.",
            likes: 205,
            imageUrl: "ironman",
            timestamp: Timestamp(),
            user: User.MOCK_USERS[2]
        ),
        .init(
            id: NSUUID().uuidString,
            ownerId: NSUUID().uuidString,
            caption: "Wakanda forever!",
            likes: 312,
            imageUrl: "black-panther-1",
            timestamp: Timestamp(),
            user: User.MOCK_USERS[3]
        ),
        .init(
            id: NSUUID().uuidString,
            ownerId: NSUUID().uuidString,
            caption: "Venom unleashed.",
            likes: 56,
            imageUrl: "venom",
            timestamp: Timestamp(),
            user: User.MOCK_USERS[4]
        ),
        .init(
            id: NSUUID().uuidString,
            ownerId: NSUUID().uuidString,
            caption: "Venom unleashed 2.",
            likes: 65,
            imageUrl: "venom",
            timestamp: Timestamp(),
            user: User.MOCK_USERS[4]
        ),
    ]
}
