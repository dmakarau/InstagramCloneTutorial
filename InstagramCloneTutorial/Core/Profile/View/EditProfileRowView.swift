//
//  EditProfileRowView.swift
//  InstagramCloneTutorial
//
//  Created by Denis Makarau on 09.09.25.
//

import SwiftUI

struct EditProfileRowView: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        HStack {
            Text(title)
                .padding(.leading, 8)
                .frame(width: 100, alignment: .leading)
            VStack {
                TextField(placeholder, text: $text)
                Divider()
                    
            }
        }
        .font(.subheadline)
        .frame(height: 36)
    }
}

#Preview {
    EditProfileRowPreviewWrapper()
}

struct EditProfileRowPreviewWrapper: View {
    @State var name = "Denis Makarau"
    var body: some View {
        EditProfileRowView(title: "Name", placeholder: "Enter name", text: $name)
    }
}
