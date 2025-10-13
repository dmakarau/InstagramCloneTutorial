//
//  NotificationsCell.swift
//  InstagramCloneTutorial
//
//  Created by Denis Makarau on 13.10.25.
//

import SwiftUI

struct NotificationsCell: View {
    var body: some View {
        HStack {
            HStack {
                CircularProfileImageView(size: .xSmall)
                
                HStack {
                    Text("Yuki")
                        .font(.subheadline)
                        .fontWeight(.semibold) +
                    
                    Text(" liked one of your posts.")
                        .font(.subheadline) +
                    
                    Text(" 3w")
                        .foregroundStyle(.gray)
                        .font(.footnote)
                }
                
                Spacer()
                
                Image("batman")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .clipped()
                    .padding(.leading, 2)
                    
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    NotificationsCell()
}
