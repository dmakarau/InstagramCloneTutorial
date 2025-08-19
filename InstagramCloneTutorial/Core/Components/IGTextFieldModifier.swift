//
//  IGTextFieldModifier.swift
//  InstagramCloneTutorial
//
//  Created by Denis Makarau on 19.08.25.
//

import SwiftUI

struct IGTextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .padding(12)
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 24))
            .padding(.horizontal, 24)
    }
    
}
