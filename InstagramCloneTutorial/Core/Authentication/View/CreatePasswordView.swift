//
//  CreatePasswordView.swift
//  InstagramCloneTutorial
//
//  Created by Denis Makarau on 19.08.25.
//

import SwiftUI

struct CreatePasswordView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(RegistrationViewModel.self) private var viewModel

    var body: some View {
        @Bindable var viewModel = viewModel
        VStack {
            Text("Create password")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top)

            Text("Your password must be at least 6 characters long.")
                .font(.footnote)
                .foregroundStyle(.gray)
                .multilineTextAlignment(.center)

            SecureField("Password", text: $viewModel.password)
                .modifier(IGTextFieldModifier())
                .padding(.top)
            
            NavigationLink {
                CompleteSighUpView()
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
    CreatePasswordView()
}
