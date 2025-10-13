//
//  IGNotification.swift
//  InstagramCloneTutorial
//
//  Created by Denis Makarau on 13.10.25.
//

import Firebase

struct IGNotification: Identifiable, Codable {
    let id: String
    var postId: String?
    let timestamp: Timestamp
    let notificationSenderUid: String
    let type: IGNotificationType
    
    var post: Post?
    var user: User?
}

