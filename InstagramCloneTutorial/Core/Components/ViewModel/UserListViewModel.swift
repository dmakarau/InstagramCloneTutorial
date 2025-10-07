//
//  UserListViewModel.swift
//  InstagramCloneTutorial
//
//  Created by Denis Makarau on 07.10.25.
//

import Foundation

@MainActor
@Observable
class UserListViewModel {
    var users = [User]()
    
    init() {
        print("DEBUG: UserListViewModel init...")
    }
    
    func fetchUsers(forConfig config: UserListConfig) async {
        do {
            self.users = try await UserService.shared.fetchUsers(forConfig: config)
        } catch {
            print("DEBUG - Failed to fetch users \(error)")
        }
        
    }
}
