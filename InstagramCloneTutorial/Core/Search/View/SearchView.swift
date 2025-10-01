//
//  SearchView.swift
//  InstagramCloneTutorial
//
//  Created by Denis Makarau on 19.08.25.
//

import SwiftUI

struct SearchView: View {
    @State private var searchedText = ""
    @State var viewModel = SearchViewModel()
    var body: some View {
        NavigationStack {
            ScrollView {
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
            }
            .navigationDestination(for: User.self, destination: { user in
                ProfileView(user: user)
            })
            .navigationTitle("Explore")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    SearchView()
}
