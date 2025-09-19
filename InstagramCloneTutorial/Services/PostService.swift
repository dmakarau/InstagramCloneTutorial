//
//  PostService.swift
//  InstagramCloneTutorial
//
//  Created by Denis Makarau on 17.09.25.
//

import Foundation
import Firebase
import FirebaseAuth

struct PostService {
    
    private static let postCollection = Firestore.firestore().collection("posts")
    
    static func fetchFeedPosts() async throws -> [Post] {
        let snapshot = try await postCollection.getDocuments()
        var posts = snapshot.documents.compactMap({ try? $0.data(as: Post.self) })
        
        for i in 0..<posts.count {
            let post = posts[i]
            let ownerUid = post.ownerId
            let postUser = try await  UserService.fetchUser(withUid: ownerUid)
            posts[i].user = postUser
        }
        return posts
    }
    
    static func fetchUserPosts(uid: String) async throws -> [Post] {
        let query = postCollection.whereField("ownerId", isEqualTo: uid)
        let snapshot = try await query.getDocuments()
        return snapshot.documents.compactMap({ try? $0.data(as: Post.self) })
    }
}
