//
//  CommentsCell.swift
//  InstagramCloneTutorial
//
//  Created by Denis Makarau on 25.09.25.
//

import SwiftUI

struct CommentsCell: View {
    
    let comment: Comment
    
    private var user: User? {
        return comment.user
    }
    
    var body: some View {
        HStack {
            CircularProfileImageView(user: user, size: .xSmall)
            
            VStack (alignment: .leading, spacing: 4) {
                HStack(spacing: 2) {
                    Text(user?.username ?? "")
                        .fontWeight(.semibold)
                    Text("6d")
                        .foregroundStyle(.gray)
                }
                
                Text(comment.commentText)
            }
            .font(.caption)
            
            Spacer()
        }
        .padding(.horizontal)
        
    }
}

#Preview {
    CommentsCell(comment: DeveloperPreview.shared.comment)
}
