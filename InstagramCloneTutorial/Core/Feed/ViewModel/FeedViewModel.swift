//
//  FeedViewModel.swift
//  InstagramCloneTutorial
//
//  Created by Denis Makarau on 17.09.25.
//

import Foundation

@Observable
class FeedViewModel {
    var posts: [Post] = []
    
    init() {
        Task { try await fetchPosts() }
    }
    
    @MainActor
    func fetchPosts() async throws {
        posts = try await PostService.fetchFeedPosts()
    }
    
}
