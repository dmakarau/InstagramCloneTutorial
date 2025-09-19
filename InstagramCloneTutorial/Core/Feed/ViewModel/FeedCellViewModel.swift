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
    }
    
    func like() async throws {
        post.didLike = true
        post.likes += 1
    }
    
    func unlike() async throws {
        post.didLike = false
        if post.likes > 0 {
            post.likes -= 1
        }
    }
    
}
