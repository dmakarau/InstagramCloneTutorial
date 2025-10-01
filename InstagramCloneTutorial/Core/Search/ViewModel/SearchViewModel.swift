//
//  SearchViewModel.swift
//  InstagramCloneTutorial
//
//  Created by Denis Makarau on 03.09.25.
//

import Foundation

class SearchViewModel: ObservableObject {
    @Published var users = [User]()
    
    init() {
        Task { try await fetchAllUsers() }
    }
    
    @MainActor
    func fetchAllUsers() async throws {
        self.users = try await UserService.shared.fetchAllUsers()
    }
}
