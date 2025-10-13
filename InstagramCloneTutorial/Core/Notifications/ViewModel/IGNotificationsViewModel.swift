//
//  IGNotificationsViewModel.swift
//  InstagramCloneTutorial
//
//  Created by Denis Makarau on 13.10.25.
//

import Foundation

@Observable
class IGNotificationsViewModel {
    var notifications = [IGNotification]()
    
    init() {
       fetchNotifications()
    }
    
    func fetchNotifications() {
        notifications = DeveloperPreview.shared.notifications
    }
}
