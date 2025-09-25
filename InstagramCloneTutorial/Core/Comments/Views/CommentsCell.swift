//
//  CommentsCell.swift
//  InstagramCloneTutorial
//
//  Created by Denis Makarau on 25.09.25.
//

import SwiftUI

struct CommentsCell: View {
    
    private var user: User {
        return User.MOCK_USERS[0]
    }
    var body: some View {
        HStack {
            CircularProfileImageView(user: User.MOCK_USERS[0], size: .xSmall)
            
            VStack (alignment: .leading, spacing: 4) {
                HStack(spacing: 2) {
                    Text(user.username)
                        .fontWeight(.semibold)
                    Text("6d")
                        .foregroundStyle(.gray)
                }
                
                Text("How is the back of my car look?")
            }
            .font(.caption)
            
            Spacer()
        }
        .padding(.horizontal)
        
    }
}

#Preview {
    CommentsCell()
}
