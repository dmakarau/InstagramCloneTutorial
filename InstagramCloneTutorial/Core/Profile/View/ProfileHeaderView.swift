//
//  ProfileHeaderView.swift
//  InstagramCloneTutorial
//
//  Created by Denis Makarau on 22.08.25.
//

import SwiftUI

struct ProfileHeaderView: View {
    @State private var showEditProfile = false
    var viewModel: ProfileViewModel
    
    private var user: User {
        viewModel.user
    }
    
    private var isFollowed: Bool {
        user.isFollowed ?? false
    }
    
    private var buttonTitle: String {
        if user.isCurrentUser {
            return "Edit Profile"
        } else {
            return isFollowed ? "Following" : "Follow"
        }
    }
    
    private var buttonBackgroundColor: Color {
        if user.isCurrentUser || isFollowed {
            return .white
        } else {
            return Color(.systemBlue)
        }
    }
    
    private var buttonForegroundColor: Color {
        if user.isCurrentUser || isFollowed {
            return .black
        } else {
            return .white
        }
    }
    
    private var buttonBorderColor: Color {
        if user.isCurrentUser || isFollowed  {
            return .gray
        } else {
            return .clear
        }
            
    }
    
    init(user: User) {
        self.viewModel = ProfileViewModel(user: user)
    }
    var body: some View {
        VStack(spacing: 10) {
            // pic and stats
            HStack {
                CircularProfileImageView(user: user, size: .large)
                
                Spacer()
                
                HStack (spacing: 8) {
                    UserStatView(value: user.stats?.postsCount ?? 0, title: "Posts")
                    
                    NavigationLink(value: UserListConfig.followers(uid: user.id)) {
                        UserStatView(value: user.stats?.followersCount ?? 0, title: "Followers")
                    }
                    NavigationLink(value: UserListConfig.following(uid: user.id)) {
                        UserStatView(value: user.stats?.followingCount ?? 0, title: "Following")
                    }
                }
            }
            .padding(.horizontal)
            // name and bio
            VStack(alignment: .leading, spacing: 4) {
                if let name = user.fullname {
                    Text(name)
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
                
                if let bio = user.bio {
                    Text(bio)
                        .font(.footnote)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            
            // action button
            Button {
                if user.isCurrentUser {
                    showEditProfile.toggle()
                } else {
                    handleFollowTapped()
                }
            } label: {
                Text(buttonTitle)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .frame(width: 360, height: 32)
                    .background(buttonBackgroundColor)
                    .foregroundStyle(buttonForegroundColor)
                    .cornerRadius(6)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(buttonBorderColor, lineWidth: 1)
                    )
            }
            Divider()
        }
        .navigationDestination(for: UserListConfig.self, destination: { config in
            UserListView(config: config)
        })
        .onAppear {
            viewModel.checkIfUserIsFollowed()
            viewModel.fetchUserStats()
        }
        .fullScreenCover(isPresented: $showEditProfile) {
            EditProfileView(user: user)
        }
    }
    
    func handleFollowTapped() {
        if isFollowed {
            viewModel.unfollow()
        } else {
            viewModel.follow()
        }
    }
}

#Preview {
    ProfileHeaderView(user: User.MOCK_USERS[0])
}
