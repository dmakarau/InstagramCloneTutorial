//
//  UploadPostViewModel.swift
//  InstagramCloneTutorial
//
//  Created by Denis Makarau on 22.08.25.
//

import SwiftUI
import PhotosUI
import Observation

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

    func loadImage(fromtItem item: PhotosPickerItem?) async  {
        guard let item = item else { return }
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: data) else { return }
        self.postImage = Image(uiImage: uiImage)
    }
}

