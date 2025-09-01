//
//  LoginViewModel.swift
//  InstagramCloneTutorial
//
//  Created by Denis Makarau on 01.09.25.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    
    func login() async throws {
       try await AuthService.shared.login(withEmail: email, password: password)
    }
}
