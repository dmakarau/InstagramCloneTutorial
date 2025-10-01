//
//  InstagramCloneTutorial
//
//  Created by Denis Makarau on 25.09.25.
//

import SwiftUI

struct CommentsView: View {
    @State private var commentText = ""
    var viewModel: CommentViewModel
    private var currentUser: User? {
        return UserService.shared.currentUser
    }

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
            CircularProfileImageView(user: currentUser, size: .xSmall)
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
                        let commentTextTemp = commentText
                        commentText = ""
                        try await viewModel.uploadComment(commentText: commentTextTemp)
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
