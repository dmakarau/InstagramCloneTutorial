//
//  CommentsView.swift
//  InstagramCloneTutorial
//
//  Created by Denis Makarau on 25.09.25.
//

import SwiftUI

struct CommentsView: View {
    @State private var commentText = ""
    var viewModel: CommentViewModel

    init (post: Post) {
        self.viewModel = CommentViewModel(post: post)
    }
    var body: some View {
        Text("Comments")
            .font(.subheadline)
            .fontWeight(.semibold)
            .padding(.top, 24)
        
        Divider()
        
        ScrollView {
            LazyVStack(spacing: 24) {
                ForEach(viewModel.comments, id: \.self) { comment in
                    CommentsCell(comment: comment)
                }
            }
        }
        .padding(.top)
        
        Divider()
        
        HStack(spacing: 12) {
            CircularProfileImageView(user: User.MOCK_USERS[0], size: .xSmall)
            ZStack(alignment: .trailing) {
                TextField("Add a comment", text: $commentText, axis: .vertical)
                    .font(.footnote)
                    .padding(12)
                    .padding(.trailing, 40)
                    .overlay {
                        Capsule()
                            .stroke(Color(.systemGray5), lineWidth: 1)
                    }
                
                Button {
                    Task {
                        try await viewModel.uploadComment(commentText: commentText)
                        commentText = ""
                    }
                } label: {
                    Text("Posts")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color(.systemBlue))
                }
                .padding(.horizontal)
            }
        }
        .padding(12)
    }
}

#Preview {
    CommentsView(post: Post.MOCK_POSTS[0])
}
