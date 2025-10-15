//  NotificationsView.swift
//  InstagramCloneTutorial
//
//  Created by Denis Makarau on 13.10.25.
//

import SwiftUI

struct NotificationsView: View {
    var viewModel = IGNotificationsViewModel(service: NotificationsService())
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 20) {
                    ForEach(viewModel.notifications) { notification in
                        NotificationsCell(notification: notification)
                            .padding(.top)
                    }
                }
            }
            .navigationDestination(for: User.self, destination: { user in
                ProfileView(user: user)
            })
            .navigationDestination(for: Post.self, destination: { post in
                FeedCell(post: post)
            })
            .navigationTitle("Notifications")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    NotificationsView()
}
