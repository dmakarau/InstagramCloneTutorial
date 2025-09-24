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

// MARK: - Like/Unlike Post
extension PostService {
    static func likePost(_ post: Post) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        async let _ = try await postCollection.document(post.id).collection("post-likes").document(uid).setData([:])
        async let _ = try await postCollection.document(post.id).updateData(["likes": post.likes + 1])
        async let _ = Firestore.firestore().collection("users").document(uid).collection("user-likes").document(post.id).setData([:])
            
    }
    
    static func unlikePost(_ post: Post) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        async let _ = try await postCollection.document(post.id).collection("post-likes").document(uid).delete()
        async let _ = try await postCollection.document(post.id).updateData(["likes": post.likes - 1])
        async let _ = Firestore.firestore().collection("users").document(uid).collection("user-likes").document(post.id).delete()
    }
    
    static func checkIfUserLikedPost(_ post: Post) async throws -> Bool {
        guard let uid = Auth.auth().currentUser?.uid else { return false }
        let snapshot = try await Firestore.firestore().collection("users").document(uid).collection("user-likes").document(post.id).getDocument()
        return snapshot.exists
    }
}
