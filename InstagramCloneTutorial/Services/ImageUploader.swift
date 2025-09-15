//
//  ImageUploader.swift
//  InstagramCloneTutorial
//
//  Created by Denis Makarau on 15.09.25.
//

import UIKit
import FirebaseStorage

struct ImageUploader {
    static func uploadImage(image: UIImage) async throws -> String? {
        guard let imageDate = image .jpegData(compressionQuality: 0.5) else {
            return nil
        }
        let filename = NSUUID().uuidString
        let filepath = Storage.storage().reference(withPath: "/profileImages/\(filename)")
        
        do {
            let _ = try await filepath.putDataAsync(imageDate)
            let url = try await filepath.downloadURL()
            return url.absoluteString
        } catch {
            print("DEBUG - Fail to upload image: \(error.localizedDescription)")
            return nil
        }
    }
}
