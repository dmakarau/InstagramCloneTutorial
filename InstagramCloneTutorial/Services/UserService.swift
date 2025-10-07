//
//  UserService.swift
//  InstagramCloneTutorial
//
//  Created by Denis Makarau on 03.09.25.
//

import Foundation
import Firebase
import FirebaseAuth
import Observation

@Observable
class UserService {

    var currentUser: User?

    static let shared = UserService()

    func fetchUser(withUid uid: String) async throws -> User {
        let snapshot = try await FirebaseConstants.UsersCollection.document(uid).getDocument()
        return try snapshot.data(as: User.self)
    }

    func fetchAllUsers() async throws -> [User] {
        let snapshot = try await FirebaseConstants.UsersCollection.getDocuments()
        return snapshot.documents.compactMap({ try? $0.data(as: User.self) })
    }
    
    @MainActor
    func fetchCurrentUser() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        self.currentUser = try await fetchUser(withUid: uid)
    }
    
    func fetchUsers(forConfig config: UserListConfig) async throws -> [User]{
        switch (config) {
        case .followers(let uid):
            return try await fetchFollowers(uid: uid)
        case .following(let uid):
            return try await fetchFollowing(uid: uid)
        case .explore:
            return try await fetchAllUsers()
        case .likes(let postId):
            return try await fetchLikes(uid: postId)
        }
    }
    
    private func fetchFollowers(uid: String) async throws -> [User] {
        let snapshot = try await FirebaseConstants.FollowersCollection
            .document(uid)
            .collection("user-followers")
            .getDocuments() // List of ids
        return try await fetchUsers(snapshot)
    }
    
    private func fetchFollowing(uid: String) async throws -> [User] {
        let snapshot = try await FirebaseConstants.FollowingCollection
            .document(uid)
            .collection("user-following")
            .getDocuments() // List of ids
        return try await fetchUsers(snapshot)
    }
    
    private func fetchLikes(uid: String) async throws -> [User] {
        return []
    }
    
    private func fetchUsers(_ snapshot: QuerySnapshot) async throws -> [User] {
        var users = [User]()
        for doc in snapshot.documents {
            users.append(try await fetchUser(withUid: doc.documentID))
        }
        return users
    }
}

// MARK: - Follow/Unfollow User
extension UserService {
    static func follow(uid: String) async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        
        async let _ = try await FirebaseConstants
            .FollowingCollection.document(currentUid)
            .collection("user-following").document(uid)
            .setData([:])
        
        async let _ = try await FirebaseConstants
            .FollowersCollection.document(uid)
            .collection("user-followers").document(currentUid)
            .setData([:])
    }
    
    static func unfollow(uid: String) async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }

        async let _ = try await FirebaseConstants
            .FollowingCollection.document(currentUid)
            .collection("user-following").document(uid)
            .delete()
        
        async let _ = try await FirebaseConstants
            .FollowersCollection.document(uid)
            .collection("user-followers").document(currentUid)
            .delete()
    }
    
    static func checkIfUserIsFollowed(uid: String) async throws -> Bool {
        guard let currentUid = Auth.auth().currentUser?.uid else { return false }
        
        let snapshot = try await FirebaseConstants
            .FollowingCollection.document(currentUid)
            .collection("user-following").document(uid).getDocument()
        
        return snapshot.exists
    }
}

// MARK: - User Stats
extension UserService {
    static func fetchUserStats(uid: String) async throws -> UserStats {
        async let followersQueryCount = FirebaseConstants.FollowersCollection.document(uid)
            .collection("user-followers")
            .getDocuments().count
        async let followingQueryCount = FirebaseConstants.FollowingCollection.document(uid)
            .collection("user-following")
            .getDocuments().count
        
        async let postsCount = FirebaseConstants.PostsCollection.whereField("ownerId", isEqualTo: uid)
            .getDocuments().count
        
        print("DEBUG: Calling user stats....")
        return try await UserStats(
            followingCount: followingQueryCount,
            followersCount: followersQueryCount,
            postsCount: postsCount
        )
    }
}
