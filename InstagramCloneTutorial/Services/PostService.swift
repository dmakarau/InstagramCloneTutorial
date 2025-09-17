//
//  PostService.swift
//  InstagramCloneTutorial
//
//  Created by Denis Makarau on 17.09.25.
//

import Foundation
import Firebase

struct PostService {
    
    static func fetchAllPosts() async throws -> [Post] {
        let snapshot = try await Firestore.firestore().collection("posts").getDocuments()
        var posts = snapshot.documents.compactMap({ try? $0.data(as: Post.self) })
        
        for i in 0..<posts.count {
            let post = posts[i]
            let ownerUid = post.ownerId
            let postUser = try await  UserService.fetchUser(withUid: ownerUid)
            posts[i].user = postUser
        }
        return posts
    }
}
