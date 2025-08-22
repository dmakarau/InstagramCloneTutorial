//
//  CurrentUserProfile.swift
//  InstagramCloneTutorial
//
//  Created by Denis Makarau on 20.08.25.
//

import SwiftUI

struct CurrentUserProfile: View {
    let user: User
    private let imageDimension: CGFloat = (UIScreen.main.bounds.width / 3) - 1
    
    var posts: [Post] {
        return Post.MOCK_POSTS.filter ({
            $0.user?.username == user.username
        })
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                // header
                ProfileHeaderView(user: user)
                // post grid view
                PostGridView(posts: Post.MOCK_POSTS)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        // Action for the button can be added here
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
