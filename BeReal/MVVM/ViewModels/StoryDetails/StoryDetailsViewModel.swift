//
//  StoryDetailsViewModel.swift
//  BeReal
//
//  Created by Vitaliy on 12.03.2025.
//

import SwiftData
import SwiftUI

class StoryDetailsViewModel: BaseViewModel {
   
    @Published var story: StoryEntity

    init(story: StoryEntity, coordinator: AppCoordinator, context: ModelContext) {
        self.story = story
        super.init(coordinator: coordinator, context: context)
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
