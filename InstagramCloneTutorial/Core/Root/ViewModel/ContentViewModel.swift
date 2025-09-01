//
//  ContentViewModel.swift
//  InstagramCloneTutorial
//
//  Created by Denis Makarau on 01.09.25.
//

import Foundation
import Firebase
import FirebaseAuth
import Combine

class ContentViewModel: ObservableObject {
    private let service = AuthService.shared
    private var cancellables: Set<AnyCancellable> = []
    
    @Published var userSession: FirebaseAuth.User?
    
    init() {
        setupSubscribers()
    }
    
    func setupSubscribers() {
        service.$userSession.sink { [weak self] userSession in
            self?.userSession = userSession
        }
        .store(in: &cancellables)
    }
}
