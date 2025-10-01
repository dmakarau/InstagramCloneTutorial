//
//  EditProfileViewModel.swift
//  InstagramCloneTutorial
//
//  Created by Denis Makarau on 09.09.25.
//

import SwiftUI
import PhotosUI
import Firebase
import Observation

@MainActor
@Observable
class EditProfileViewModel {
    var user: User
    var fullname = ""
    var bio = ""
    var selectedImage: PhotosPickerItem? {
        didSet {
            Task {
                if let selectedImage = selectedImage {
                    await loadImage(fromtItem: selectedImage)
                }
            }
        }
    }

    private var uiImage: UIImage?

    init(user: User) {
        self.user = user

        if let fullname  = user.fullname {
            self.fullname = fullname
        }
        if let bio  = user.bio {
            self.bio = bio
        }
    }

    var profileImage: Image?

    func loadImage(fromtItem item: PhotosPickerItem?) async  {
        guard let item = item else { return }
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: data) else { return }

        self.uiImage = uiImage
        self.profileImage = Image(uiImage: uiImage)
    }
    
    func updateUserData() async throws {
       // update profile image if changed
        
        var data = [String: Any]()
        
        if let uiImage = uiImage {
            let imageURL = try? await ImageUploader.uploadImage(image: uiImage)
            data["profileImageUrl"] = imageURL
        }
        
        // update name if changed
        if !fullname.isEmpty && user.fullname != fullname {
            data["fullname"] = fullname
        }
        
        // update bio if changed
        if !bio.isEmpty && user.bio != bio {
            data["bio"] = bio
        }
        
        if !data.isEmpty {
            try await Firestore.firestore().collection("users").document(user.id).updateData(data)
        }
    }

}
 
