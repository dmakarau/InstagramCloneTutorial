//
//  LoginViewModel.swift
//  InstagramCloneTutorial
//
//  Created by Denis Makarau on 01.09.25.
//

import Foundation
import Observation

@Observable
class LoginViewModel {
    var email: String = ""
    var password: String = ""
    
    func login() async throws {
       try await AuthService.shared.login(withEmail: email, password: password)
    }
}
