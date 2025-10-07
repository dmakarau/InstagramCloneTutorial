//
//  ProfileViewModel.swift
//  InstagramCloneTutorial
//
//  Created by Denis Makarau on 07.10.25.
//

import Foundation

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
        user.isFollowed = true
    }
    
    func unfollow() {
        user.isFollowed = false
    }
    
    func checkIfUserIsFollowed() {
        
    }
}
