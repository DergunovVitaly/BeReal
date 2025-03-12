//
//  StoryDetailsViewModel.swift
//  BeReal
//
//  Created by Vitaliy on 12.03.2025.
//


import SwiftUI

class StoryDetailsViewModel: ObservableObject {
    @Published var story: Story
    let coordinator: AppCoordinator

    init(story: Story, coordinator: AppCoordinator) {
        self.story = story
        self.coordinator = coordinator
    }

    func toggleLike() {
        story.isLiked.toggle()
        objectWillChange.send()
    }

    func markAsSeen() {
        story.isSeen = true
        objectWillChange.send()
    }
}
