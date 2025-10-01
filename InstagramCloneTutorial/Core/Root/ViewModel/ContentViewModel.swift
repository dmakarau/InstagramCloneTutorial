//
//  ContentViewModel.swift
//  InstagramCloneTutorial
//
//  Created by Denis Makarau on 01.09.25.
//

import Foundation
import Firebase
import FirebaseAuth
import Observation

@Observable
class ContentViewModel {
    var userSession: FirebaseAuth.User? { AuthService.shared.userSession }
    var currentUser: User? { UserService.shared.currentUser }
}
