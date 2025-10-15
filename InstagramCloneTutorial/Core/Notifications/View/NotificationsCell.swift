//
//  NotificationsCell.swift
//  InstagramCloneTutorial
//
//  Created by Denis Makarau on 13.10.25.
//

import SwiftUI
import Kingfisher

struct NotificationsCell: View {
    let notification: IGNotification
    var body: some View {
        HStack {
            HStack {
                NavigationLink(value: notification.user) {
                    CircularProfileImageView(user: notification.user, size: .xSmall)
                }
                HStack {
                    Text(notification.user?.username ?? "Unknown")
                        .font(.subheadline)
                        .fontWeight(.semibold) +
                    
                    Text(" \(notification.type.notificationMessage)")
                        .font(.subheadline) +
                    
                    Text("\(notification.timestamp.timestampString())")
                        .foregroundStyle(.gray)
                        .font(.footnote)
                }
                
                Spacer()
                
                if notification.type != .follow {
                    NavigationLink(value: notification.post) {
                        KFImage(URL(string: notification.post?.imageUrl ?? ""))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 40)
                            .clipped()
                            .padding(.leading, 2)
                    }
                } else {
                    Button {
                        // Handle folow action
                        print("Follow button tapped")
                    } label: {
                        Text("Follow")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .frame(width: 88, height: 32)
                            .foregroundStyle(.white)
                            .background(.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 6))
                    }
                }
                
               
                    
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    NotificationsCell(notification: DeveloperPreview.shared.notifications[1])
}
