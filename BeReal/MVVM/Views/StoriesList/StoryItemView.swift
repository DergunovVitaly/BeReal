//
//  StoryItemView.swift
//  BeReal
//
//  Created by Vitaliy on 12.03.2025.
//
import SwiftUI

struct StoryItemView: View {
    let story: Story
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: story.profilePictureURL)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } else if phase.error != nil {
                    Color.red
                } else {
                    ProgressView()
                }
            }
            .frame(width: 70, height: 70)
            .clipShape(Circle())
            .overlay(
                Circle().stroke(story.isSeen ? Color.gray : Color.blue, lineWidth: 3)
            )
            
            Text(story.name)
                .font(.caption)
        }
    }
}
