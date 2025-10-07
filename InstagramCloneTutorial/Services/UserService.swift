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
