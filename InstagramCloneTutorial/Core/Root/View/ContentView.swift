//
//  ContentView.swift
//  InstagramCloneTutorial
//
//  Created by Denis Makarau on 13.08.25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    @StateObject var registrationViewModel = RegistrationViewModel()
    var body: some View {
        if viewModel.userSession == nil {
                LoginView()
                    .environmentObject(registrationViewModel)
        } else if let currentUser = viewModel.currentUser {
                MainTabView(user: currentUser)
        }
    }
}

#Preview {
    ContentView()
}
