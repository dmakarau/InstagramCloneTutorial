//
//  ContentView.swift
//  InstagramCloneTutorial
//
//  Created by Denis Makarau on 13.08.25.
//

import SwiftUI

struct ContentView: View {
    @State var viewModel = ContentViewModel()
    var body: some View {
        if viewModel.userSession == nil {
                LoginView()
        } else if let currentUser = viewModel.currentUser {
                MainTabView(user: currentUser)
        }
    }
}

#Preview {
    ContentView()
}
