//
//  UploadPostViewModel.swift
//  InstagramCloneTutorial
//
//  Created by Denis Makarau on 22.08.25.
//

import SwiftUI
import PhotosUI
import Observation
import FirebaseAuth
import Firebase

@Observable
class UploadPostViewModel {
    
    var selectedImage: PhotosPickerItem? {
        didSet { 
            Task { 
                if let selectedImage = selectedImage {
                    await loadImage(fromtItem: selectedImage) 
                }
            }
        }
    }
    
    var postImage: Image?
    
    private var uiImage: UIImage?

    func loadImage(fromtItem item: PhotosPickerItem?) async  {
        guard let item = item else { return }
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: data) else { return }
        self.uiImage = uiImage
        self.postImage = Image(uiImage: uiImage)
    }
    
    func uploadPost(caption: String) async throws {
        
        // Only authenticated users are allowed to upload the posts
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        // The image should be selected via Photopicker to be able to upload a post
        guard let uiImage = uiImage else  { return }
        
        // create a firebase instance document for the post
        let postRef = Firestore.firestore().collection("posts").document()
        
        // upload the image to the Firebase
        guard let imageUrl = try? await ImageUploader.uploadImage(image: uiImage) else { return }
        
        // create a Post object
        let post = Post(
            id: postRef.documentID, // reference to the Firebase storage
            ownerId: uid,           // id of the authenticated user
            caption: caption,       // caption of the post
            likes: 0,               // no likes when the post is beeing uploaded
            imageUrl: imageUrl,     // getting the image URL after the upload the image
            timestamp: Timestamp()  // current time
        )
        
        // encode the post, using Firebase
        guard let encodedPost = try? Firestore.Encoder().encode(post) else { return }
        
        // upload the data
        try await postRef.setData(encodedPost)
    }
}

