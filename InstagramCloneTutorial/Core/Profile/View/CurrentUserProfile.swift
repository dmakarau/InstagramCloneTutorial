//
//  CurrentUserProfile.swift
//  InstagramCloneTutorial
//
//  Created by Denis Makarau on 20.08.25.
//

import SwiftUI

struct CurrentUserProfile: View {
    let user: User

    var body: some View {
        NavigationStack {
            ScrollView {
                // header
                ProfileHeaderView(user: user)
                // post grid view
                PostGridView(user: user)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        AuthService.shared.signOut()
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .foregroundStyle(.black)
                    }
                }
            }
        }
    }
}

#Preview {
    CurrentUserProfile(user: User.MOCK_USERS[3])
}
