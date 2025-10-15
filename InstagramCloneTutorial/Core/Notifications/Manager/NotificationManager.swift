//
//  NotificationManager.swift
//  InstagramCloneTutorial
//
//  Created by Denis Makarau on 15.10.25.
//

import Foundation

class NotificationManager {
    
    private let service = NotificationsService()
    
    static let shared = NotificationManager()
    private init() {}
    
    func uploadLikeNotification(to uid: String, post: Post) async throws {
        try await service.uploadNotification(toUid: uid, type: .like, post: post)
    }
    
    func uploadCommenttification(to uid: String, post: Post) async throws {
        try await service.uploadNotification(toUid: uid, type: .comment, post: post)

    }
    
    func uploadFollowNotification(to uid: String) async throws {
        try await service.uploadNotification(toUid: uid, type: .follow)
    }
    
    func deleteLikeNotification(notificationOwner: String, post: Post) async {
        do {
            try await service.deleteNotification(toUid: notificationOwner, type: .like, post: post)
        } catch {
            print("DEBUG: Failed to delete like notification with error \(error.localizedDescription)")
        }
    }
}
