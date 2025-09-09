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
    
    var profileImage: Image?
    
    func loadImage(fromtItem item: PhotosPickerItem?) async  {
        guard let item = item else { return }
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: data) else { return }
        self.profileImage = Image(uiImage: uiImage)
    }

}
