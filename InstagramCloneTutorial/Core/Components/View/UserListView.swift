//
//  UserListView.swift
//  InstagramCloneTutorial
//
//  Created by Denis Makarau on 07.10.25.
//

import SwiftUI

struct UserListView: View {
    var viewModel = UserListViewModel()
    @State private var searchedText = ""
    
    private let config: UserListConfig
    
    init(config: UserListConfig) {
        self.config = config
    }
    var body: some View {
        LazyVStack(spacing: 20) {
            ForEach(viewModel.users) { (user: User) in
                NavigationLink(value: user) {
                    HStack {
                        CircularProfileImageView(user: user, size: .xSmall)
                        VStack(alignment: .leading) {
                            Text(user.username)
                                .fontWeight(.semibold)
                            if let name = user.fullname {
                                Text(name)
                            }
                        }
                        .font(.footnote)
                        
                        Spacer()
                    }
                    .foregroundStyle(.black)
                    .padding(.horizontal)
                }
            }
        }
        .padding(.top, 8)
        .searchable(text: $searchedText, prompt: "Search..")
        .task { await viewModel.fetchUsers(forConfig: config) }
    }
}

#Preview {
    UserListView(config: .explore)
}
