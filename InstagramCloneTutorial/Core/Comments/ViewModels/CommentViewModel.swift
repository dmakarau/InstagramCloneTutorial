//  CommentViewModel.swift
//  InstagramCloneTutorial
//
//  Created by Denis Makarau on 25.09.25.
//

import Foundation
import Firebase
import FirebaseAuth

@MainActor
@Observable
class CommentViewModel {
    var comments = [Comment]()
    
    private let post: Post
    private let commentService: CommentService
    
    init(post: Post) {
        self.post = post
        self.commentService = CommentService(postId: post.id)
        Task { try await fetchComments() }
    }
    
    func uploadComment(commentText: String) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let comment = Comment(
            commentText: commentText,
            postId: post.id,
            postOwnerUid: post.ownerId,
            timestamp: Timestamp(),
            commentOwnerUid: uid
        )
        
        comments.insert(comment, at: 0)
        comments[0].user = UserService.shared.currentUser
        try await commentService.uploadComment(comment)
        try await fetchComments()
        try await NotificationManager.shared.uploadCommenttification(to: post.ownerId, post: post)
        
    }
    
    func fetchComments() async throws {
        self.comments = try await commentService.fetchComments(forPostId: post.id)
        try await fetchUserDataForComments()
    }
    
    private func fetchUserDataForComments() async throws {
        for i in 0..<comments.count {
            let comment = comments[i]
            let commentUser = try await UserService.shared.fetchUser(withUid: comment.commentOwnerUid)
            comments[i].user = commentUser
        }
    }
}
