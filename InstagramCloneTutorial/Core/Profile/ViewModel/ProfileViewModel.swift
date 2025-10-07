//
//  ProfileViewModel.swift
//  InstagramCloneTutorial
//
//  Created by Denis Makarau on 07.10.25.
//

import Foundation

@MainActor
@Observable
class ProfileViewModel {
    var user: User
    
    init(user: User) {
        self.user = user
        checkIfUserIsFollowed()
    }
}

// MARK: - Following feature
extension ProfileViewModel {
    func follow() {
        Task {
            try await UserService.follow(uid: user.id)
            user.isFollowed = true
        }
    }
    
    func unfollow() {
        Task {
            try await UserService.unfollow(uid: user.id)
            user.isFollowed = false
        }
    }
    
    func checkIfUserIsFollowed() {
        Task {
            self.user.isFollowed = try await UserService.checkIfUserIsFollowed(uid: user.id)
        }
        
    }
}
