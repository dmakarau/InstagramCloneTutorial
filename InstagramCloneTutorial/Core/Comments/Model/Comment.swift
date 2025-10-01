//
//  Comment.swift
//  InstagramCloneTutorial
//
//  Created by Denis Makarau on 25.09.25.
//

import Foundation
import Firebase
import FirebaseFirestore

struct Comment: Identifiable, Hashable, Codable {
    @DocumentID var commentId: String?
    let commentText: String
    let postId: String
    let postOwnerUid: String
    let timestamp: Timestamp
    let commentOwnerUid: String
    var user: User?
    
    var id: String {
        return commentId ?? NSUUID().uuidString
    }
    
}
