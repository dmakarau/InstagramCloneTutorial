//
//  EditProfileViewModel.swift
//  InstagramCloneTutorial
//
//  Created by Denis Makarau on 09.09.25.
//

import SwiftUI
import PhotosUI
import Firebase

class EditProfileViewModel: ObservableObject {
    @Published var user: User
    @Published var fullname = ""
    @Published var bio = ""
    @Published var selectedImage: PhotosPickerItem? {
        didSet {
            Task {
                if let selectedImage = selectedImage {
                    await loadImage(fromtItem: selectedImage)
                }
            }
        }
    }
    
    init(user: User) {
        self.user = user
    }
    
    var profileImage: Image?
    
    func loadImage(fromtItem item: PhotosPickerItem?) async  {
        guard let item = item else { return }
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: data) else { return }
        self.profileImage = Image(uiImage: uiImage)
    }
    
    func updateUserData() async throws {
       // update profile image if changed
        
        var data = [String: Any]()
        
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
 
