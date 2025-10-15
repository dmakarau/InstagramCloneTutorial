//
//  FeedCellViewModel.swift
//  InstagramCloneTutorial
//
//  Created by Denis Makarau on 19.09.25.
//

import Foundation

@Observable
class FeedCellViewModel {
    var post: Post
    
    init(post: Post) {
        self.post = post
        Task { try await checkIfUserLikedPost() }
    }
    
    func like() async throws {
        do {
            let postCopy = post
            post.didLike = true
            post.likes += 1
            try await PostService.likePost(postCopy)
            // TODO when notifications uploading failed the like is reverted, because it is in catch
            try await NotificationManager.shared.uploadLikeNotification(to: post.ownerId, post: post)
        } catch {
            post.didLike = false
            if post.likes > 0 {
                post.likes -= 1
            }
        }
    }
    
    func unlike() async throws {
        do {
            let postCopy = post
            post.didLike = false
            if post.likes > 0 {
                post.likes -= 1
            }
            try await PostService.unlikePost(postCopy)
            await NotificationManager.shared.deleteLikeNotification(notificationOwner: post.ownerId, post: post)
            
        } catch {
            post.didLike = true
            post.likes += 1
        }
    }
    
    func checkIfUserLikedPost() async throws {
        self.post.didLike = try await PostService.checkIfUserLikedPost(post)
    }
}
