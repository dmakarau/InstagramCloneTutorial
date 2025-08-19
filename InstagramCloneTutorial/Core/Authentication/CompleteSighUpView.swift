//
//  CompleteSighUpView.swift
//  InstagramCloneTutorial
//
//  Created by Denis Makarau on 19.08.25.
//

import SwiftUI

struct CompleteSighUpView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        
        VStack {
            Spacer()
            Text("Welcome to Instagram, denis makarau")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top)
                .multilineTextAlignment(.center)

            Text("Click below to complete registration and start using Instagram")
                .font(.footnote)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
        
            
            Button {
                print("Complete sigh up")
            } label: {
                Text("Complete Sign Up")
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
    CompleteSighUpView()
}
