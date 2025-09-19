//
//  PostGridViewModel.swift
//  InstagramCloneTutorial
//
//  Created by Denis Makarau on 19.09.25.
//

import Foundation

@Observable
class PostGridViewModel {
    private let user: User
    var posts: [Post] = []
    
    init(user: User) {
        self.user = user
        Task { try await fetchUserPosts() }
    }
    
    @MainActor
    func fetchUserPosts() async throws {
        self.posts = try await PostService.fetchUserPosts(uid: user.id)
        
        for i in 0..<posts.count {
            posts[i].user = self.user
        }
    }
}
