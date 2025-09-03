//
//  RegistrationViewMode.swift
//  InstagramCloneTutorial
//
//  Created by Denis Makarau on 01.09.25.
//

import Foundation

class RegistrationViewModel: ObservableObject {
    @Published var username =  ""
    @Published var email =  ""
    @Published var password =  ""
    
    func createUser() async throws {
        try await AuthService.shared.createUser(email: email, password: password, username: username)
        username = ""
        email = ""
        password = ""
    }
}
