//
//  PostGridView.swift
//  InstagramCloneTutorial
//
//  Created by Denis Makarau on 22.08.25.
//

import SwiftUI
import Kingfisher

struct PostGridView: View {
    @State var viewModel: PostGridViewModel

    init(user: User) {
        self._viewModel = State(wrappedValue: PostGridViewModel(user: user))
    }
    
    private let gridItems: [GridItem] = [
        .init(.flexible(), spacing: 1),
        .init(.flexible(), spacing: 1),
        .init(.flexible(), spacing: 1)
    ]
    
    private let imageDimension: CGFloat = (UIScreen.main.bounds.width / 3) - 1

    var body: some View {
        LazyVGrid(columns: gridItems, spacing: 1) {
            ForEach(viewModel.posts) { post  in
                KFImage(URL(string: post.imageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: imageDimension, height: imageDimension)
                    .clipped()
            }
        }
    }
}

#Preview {
    PostGridView(user: User.MOCK_USERS[0])
}
