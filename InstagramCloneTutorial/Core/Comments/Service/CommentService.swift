//
//  CommentService.swift
//  InstagramCloneTutorial
//
//  Created by Denis Makarau on 25.09.25.
//

import Foundation
import Firebase
import FirebaseFirestore

struct CommentService {
    let postId: String
    
    func uploadComment(_ comment: Comment) async throws {
        guard let commentData = try? Firestore.Encoder().encode(comment) else { return }
        
        try await FirebaseConstants.PostsCollection.document(postId)
            .collection("post-comments").addDocument(data: commentData)
        
    }
    
    func fetchComments(forPostId postId: String) async throws -> [Comment] {
        let snapshot =  try await FirebaseConstants.PostsCollection.document(postId)
            .collection("post-comments")
            .order(by: "timestamp", descending: true).getDocuments()
        
        return snapshot.documents.compactMap({ try? $0.data(as: Comment.self) })
    }
    
}
