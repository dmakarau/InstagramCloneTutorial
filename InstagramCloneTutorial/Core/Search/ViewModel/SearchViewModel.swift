//
//  SearchViewModel.swift
//  InstagramCloneTutorial
//
//  Created by Denis Makarau on 03.09.25.
//

import Foundation
import Observation

@MainActor
@Observable
class SearchViewModel {
    var users = [User]()

    init() {
        Task { try await fetchAllUsers() }
    }

    func fetchAllUsers() async throws {
        self.users = try await UserService.shared.fetchAllUsers()
    }
}
