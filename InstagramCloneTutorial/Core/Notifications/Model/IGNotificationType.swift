//
//  IGNotificationType.swift
//  InstagramCloneTutorial
//
//  Created by Denis Makarau on 13.10.25.
//

import Foundation

enum IGNotificationType: Int, Codable {
    case like
    case comment
    case follow
    
    var notificationMessage: String {
        switch self {
        case .like: return "liked one of your post"
        case .comment: return "commented on one of your post"
        case .follow: return "started following you"
        }
    }
}
