//
//  IGNotificationsViewModel.swift
//  InstagramCloneTutorial
//
//  Created by Denis Makarau on 13.10.25.
//

import Foundation

@MainActor
@Observable
class IGNotificationsViewModel {
    var notifications = [IGNotification]()
    private let service: NotificationsService
    private let currentUser: User?
    
    init(service: NotificationsService) {
        self.service = service
        self.currentUser = UserService.shared.currentUser
        Task { await fetchNotifications() }
    }
    
    func fetchNotifications() async  {
        do {
            self.notifications = try await service.fetchNotifications()
            try await updateNotifications()
        } catch {
            print("DEBUG: Failed to fetch notifications with error \(error.localizedDescription)")
        }
    }
    
    private func updateNotifications() async throws {
        // TODO Possible issue here we are waiting for each notification to fetch
        // to improve it we can use async let to fetch all users/posts concurrently
        for i in 0 ..< notifications.count {
            var notification = notifications[i]
            
            notification.user = try await UserService.shared.fetchUser(withUid: notification.notificationSenderUid)
            if let postId = notification.postId {
                notification.post = try await PostService.fetchPost(withId: postId)
                notification.post?.user = self.currentUser
                
            }
            notifications[i] = notification
        }
    }
}
