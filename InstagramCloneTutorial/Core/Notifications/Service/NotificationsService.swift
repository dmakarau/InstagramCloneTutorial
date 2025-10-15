//
//  NotificationsService.swift
//  InstagramCloneTutorial
//
//  Created by Denis Makarau on 13.10.25.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation

class NotificationsService {
    
    func fetchNotifications() async throws -> [IGNotification] {
        guard let currentUid = Auth.auth().currentUser?.uid else { return [] }
        
        let snapshot = try await FirebaseConstants
            .UserNotificationCollection(uid: currentUid).getDocuments()
        
        return snapshot.documents.compactMap({ try? $0.data(as: IGNotification.self)})
    }
    
    func uploadNotification(toUid uid: String, type: IGNotificationType, post: Post? = nil) async throws {
        // get current user uid and check we are not sending notification to ourself
        guard let currentUid = Auth.auth().currentUser?.uid,
              uid != currentUid
        else { return }
        
        // create a reference to the notifications collection
        let ref = FirebaseConstants.UserNotificationCollection(uid: currentUid).document()
        
        // create a notification object
        let notification = IGNotification(
            id: ref.documentID,
            postId: post?.id,
            timestamp: Timestamp(),
            notificationSenderUid: currentUid,
            type: type
        )
        
        // encode the notification object and upload it to the Firestore
        guard let notificationData = try? Firestore.Encoder().encode(notification) else { return }
        try await ref.setData(notificationData)
        
    }
    
    func deleteNotification(toUid uid: String, type: IGNotificationType, post: Post? = nil) async throws {
    }

    
    
    
    
}
