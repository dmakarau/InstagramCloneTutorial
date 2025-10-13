//
//  DeveloperPreview.swift
//  InstagramCloneTutorial
//
//  Created by Denis Makarau on 01.10.25.
//

import Foundation
import SwiftUI
import Firebase

extension PreviewProvider {
    
    static var dev: DeveloperPreview {
        return DeveloperPreview.shared
    }
}

class DeveloperPreview {
    static let shared = DeveloperPreview()
    let comment = Comment(
        commentText: "This is a comment",
        postId: "234",
        postOwnerUid: "owner123",
        timestamp: Timestamp(),
        commentOwnerUid: "123"
    )
    
    let notifications: [IGNotification] = [
        .init(
            id: NSUUID().uuidString,
            timestamp: Timestamp(),
            notificationSenderUid: "123",
            type: .like,
        ),
        .init(
            id: NSUUID().uuidString,
            timestamp: Timestamp(),
            notificationSenderUid: "456",
            type: .follow,
        ),
        .init(
            id: NSUUID().uuidString,
            timestamp: Timestamp(),
            notificationSenderUid: "789",
            type: .comment,
        ),
        .init(
            id: NSUUID().uuidString,
            timestamp: Timestamp(),
            notificationSenderUid: "abc",
            type: .like,
        ),
        .init(
            id: NSUUID().uuidString,
            timestamp: Timestamp(),
            notificationSenderUid: "def",
            type: .follow,
        ),
    ]
    
}
