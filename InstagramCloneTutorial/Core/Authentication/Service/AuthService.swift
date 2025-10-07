//
//  AuthService.swift
//  InstagramCloneTutorial
//
//  Created by Denis Makarau on 01.09.25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import Observation

@Observable
class AuthService {

    var userSession: FirebaseAuth.User?

    static let shared = AuthService()
    
    init() {
        Task { try await loadUserData() }
    }
    
    @MainActor
    func login(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            try await loadUserData()
            
        } catch {
            print("DEBUG-> Failed to sign in a user: \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func createUser(email: String, password: String, username: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            await uploadUserDate(uid: result.user.uid, username: username, email: email)
        } catch {
            print("DEBUG-> Failed to register a user: \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func loadUserData() async throws {
        self.userSession = Auth.auth().currentUser
        guard let currentUid = userSession?.uid else { return }
        UserService.shared.currentUser = try await UserService.shared.fetchUser(withUid: currentUid)
    }
    
    func signOut() {
        try? Auth.auth().signOut()
        self.userSession = nil
        UserService.shared.currentUser = nil
    }
    
    private func uploadUserDate(uid: String, username: String, email: String) async {
        let user = User(id: uid, username: username , email: email)
        UserService.shared.currentUser = user
        guard let encodedUser = try? Firestore.Encoder().encode(user) else { return }
        try? await FirebaseConstants.UsersCollection.document(user.id).setData(encodedUser)
    }
}
