//  NotificationsView.swift
//  InstagramCloneTutorial
//
//  Created by Denis Makarau on 13.10.25.
//

import SwiftUI

struct NotificationsView: View {
    var viewModel = IGNotificationsViewModel()
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
            .navigationTitle("Notifications")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    NotificationsView()
}
