//
//  EditProfileView.swift
//  InstagramCloneTutorial
//
//  Created by Denis Makarau on 09.09.25.
//

import SwiftUI
import PhotosUI

struct EditProfileView: View {
    @Environment(\.dismiss) var dismiss
    @State private var viewModel: EditProfileViewModel

    @ViewBuilder
    private func profileImageView() -> some View {
        if let image = viewModel.profileImage {
            image
                .resizable()
                .foregroundStyle(.white)
                .background(.gray)
                .clipShape(Circle())
                .frame(width: 80, height: 80)
        } else {
            CircularProfileImageView(user: viewModel.user, size: .large)
        }
    }

    init(user: User) {
        self._viewModel = State(wrappedValue: EditProfileViewModel(user: user))
    }

    @MainActor
    var body: some View {
        let user = viewModel.user
        @Bindable var viewModel = viewModel
        VStack {
            // toolbar
            VStack {
                HStack {
                    Button("Cancel") {
                        dismiss()
                    }
                    
                    Spacer()
                    
                    Text("Edit Profile")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Button {
                        Task {
                            try await viewModel.updateUserData()
                            dismiss()
                        }
                    } label: {
                        Text("Done")
                            .font(.subheadline)
                            .fontWeight(.bold)
                    }
                }
                .padding(.horizontal)
                
                Divider()
            }
            
            // edit profile pic
            
            PhotosPicker(selection: $viewModel.selectedImage)  {
                VStack {
                    profileImageView()
                    
                    Text("Edit Profile Picture")
                        .font(.footnote)
                        .fontWeight(.semibold)
                    
                    Divider()
                }
            }
            .padding(.vertical, 8)
            
            // edit profile info
            VStack {
                EditProfileRowView(title: "Name", placeholder: "Enter your name", text: $viewModel.fullname)
                EditProfileRowView(title: "Bio", placeholder: "Enter your bio", text: $viewModel.bio)
            }
            
            Spacer()
        }
    }
}

#Preview {
    EditProfileView(user: User.MOCK_USERS[0])
}
