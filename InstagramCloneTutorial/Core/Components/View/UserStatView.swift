//
//  UserStatView.swift
//  InstagramCloneTutorial
//
//  Created by Denis Makarau on 14.08.25.
//

import SwiftUI

struct UserStatView: View {
    let value: Int
    let title: String
    
    var body: some View {
        VStack {
            Text("\(value)")
                .font(.subheadline)
                .fontWeight(.semibold)
            Text(title)
                .font(.footnote)
        }
        .opacity(value == 0 ? 0.5 : 1)
        .frame(width: 76)
    }
}

#Preview {
    UserStatView(value: 12, title: "Posts")
}
