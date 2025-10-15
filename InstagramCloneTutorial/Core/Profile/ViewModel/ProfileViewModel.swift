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
    }
}

// MARK: - Following feature
extension ProfileViewModel {
    func follow() {
        Task {
            try await UserService.follow(uid: user.id)
            user.isFollowed = true
            try await NotificationManager.shared.uploadFollowNotification(to: user.id)
        }
    }
    
    func unfollow() {
        Task {
            try await UserService.unfollow(uid: user.id)
            user.isFollowed = false
        }
    }
    
    func checkIfUserIsFollowed() {
        guard user.isFollowed == nil else {
            return
        }
        Task {
            self.user.isFollowed = try await UserService.checkIfUserIsFollowed(uid: user.id)
        }
    }
}

// MARK: - User stats
extension ProfileViewModel {
    func fetchUserStats() {
        guard user.stats == nil else {
            return
        }
        Task {
            user.stats = try await UserService.fetchUserStats(uid: user.id)
        }
    }
}

