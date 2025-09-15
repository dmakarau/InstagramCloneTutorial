//
//  UploadPostView.swift
//  InstagramCloneTutorial
//
//  Created by Denis Makarau on 22.08.25.
//

import SwiftUI
import PhotosUI

struct UploadPostView: View {
    @State private var caption: String = ""
    @State private var imagePickerPresented: Bool = false
    @State var viewModel = UploadPostViewModel()
    @Binding var tabIndex: Int
    
    var body: some View {
        
        VStack {
            // action toolbar
            HStack {
                Button {
                    clearPostDataAndReturnToFeed()
                } label: {
                    Text("Cancel")
                }
                .fontWeight(.semibold)
                
                Spacer()
                
                Text("New Post")
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button {
                    Task {
                        try await viewModel.uploadPost(caption: caption)
                        clearPostDataAndReturnToFeed()
                    }
                } label: {
                    Text("Upload")
                        .fontWeight(.semibold)
                    
                }
            }
            .padding(.horizontal)
            
            // post image and caption
            HStack(spacing: 8) {
                if let image = viewModel.postImage {
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipped()
                }
              
                TextField("Enter your caption...", text: $caption, axis: .vertical)
            }
            .padding()
            
            Spacer()
        }
        .onAppear {
            imagePickerPresented.toggle()
        }
        .photosPicker(
            isPresented: $imagePickerPresented,
            selection: $viewModel.selectedImage
        )
    }
    
    private func clearPostDataAndReturnToFeed() {
        caption = ""
        viewModel.selectedImage = nil
        viewModel.postImage = nil
        tabIndex = 0
    }
}

#Preview {
    UploadPostView(tabIndex: .constant(0))
}
