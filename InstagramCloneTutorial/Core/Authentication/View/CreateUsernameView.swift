//
//  CreateUsernameView.swift
//  InstagramCloneTutorial
//
//  Created by Denis Makarau on 19.08.25.
//

import SwiftUI

struct CreateUsernameView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(RegistrationViewModel.self) private var viewModel

    var body: some View {
        @Bindable var viewModel = viewModel
        VStack {
            Text("Create username")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top)

            Text("You'll use this email to sign in to your account")
                .font(.footnote)
                .foregroundStyle(.gray)
                .multilineTextAlignment(.center)

            TextField("Username", text: $viewModel.username)
                .textInputAutocapitalization(.none)
                .modifier(IGTextFieldModifier())
                .padding(.top)
            
            NavigationLink {
                CreatePasswordView()
                    .navigationBarBackButtonHidden()
            } label: {
                Text("Next")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .frame(width: 360, height: 44)
                    .background(Color(.systemBlue))
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            .padding(.vertical)
            
            Spacer()
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Image(systemName: "chevron.left")
                    .imageScale(.large)
                    .onTapGesture {
                        dismiss()
                    }
            }
        }
    }
}

#Preview {
    CreateUsernameView()
}
