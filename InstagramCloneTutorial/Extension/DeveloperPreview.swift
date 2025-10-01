//
//  DeveloperPreview.swift
//  InstagramCloneTutorial
//
//  Created by Denis Makarau on 01.10.25.
//

import Foundation
import SwiftUI
import Firebase

extension PreviewProvider {
    
    static var dev: DeveloperPreview {
        return DeveloperPreview.shared
    }
}

class DeveloperPreview {
    static let shared = DeveloperPreview()
    let comment = Comment(
        commentText: "This is a comment",
        postId: "234",
        postOwnerUid: "owner123",
        timestamp: Timestamp(),
        commentOwnerUid: "123"
    )
}
