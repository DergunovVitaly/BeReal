//
//  StoryDetailsViewModel.swift
//  BeReal
//
//  Created by Vitaliy on 12.03.2025.
//

import SwiftData
import SwiftUI

class StoryDetailsViewModel: ObservableObject {
    @Published var story: StoryEntity
    let coordinator: AppCoordinator
    let context: ModelContext

    init(story: StoryEntity, coordinator: AppCoordinator, context: ModelContext) {
        self.story = story
        self.coordinator = coordinator
        self.context = context
    }

    func toggleLike() {
        story.isLiked.toggle()
        try? context.save()
    }

    func markAsSeen() {
        story.isSeen = true
        try? context.save()
    }
    
    func goBack() {
        coordinator.goBack()
    }
}
