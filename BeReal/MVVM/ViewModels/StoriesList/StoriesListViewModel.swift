//
//  StoriesListViewModel.swift
//  BeReal
//
//  Created by Vitaliy on 12.03.2025.
//

import SwiftUI

class StoriesListViewModel: ObservableObject {
    
    let coordinator: AppCoordinator
    @Published var stories: [Story] = []
    @Published var errorMessage: String?
    @Published var isLoadingMore = false
    
    private var currentPage = 1
    private let pageSize = 10
    
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
    
    @MainActor
    func loadInitialStories() {
        Task {
            let result = await NetworkService.shared.fetchStories()
            switch result {
            case .success(let loadedStories):
                self.stories = loadedStories
            case .failure(let error):
                self.errorMessage = "Error loading stories: \(error)"
            }
        }
    }
    
    func markStoryAsSeen(_ story: Story) {
        if let index = stories.firstIndex(where: { $0.id == story.id }) {
            stories[index].isSeen = true
            objectWillChange.send()
        }
    }
    
    func toggleLike(for story: Story) {
        if let index = stories.firstIndex(where: { $0.id == story.id }) {
            stories[index].isLiked.toggle()
            objectWillChange.send()
        }
    }
    
    @MainActor
    func loadMoreStories() async {
        guard !isLoadingMore else { return }
        isLoadingMore = true
        
        Task {
            let result = await NetworkService.shared.fetchStories(page: currentPage + 1, pageSize: pageSize)
            switch result {
            case .success(let newStories):
                if !newStories.isEmpty {
                    self.stories.append(contentsOf: newStories)
                    self.currentPage += 1
                }
            case .failure(let error):
                self.errorMessage = "Error loading more stories: \(error)"
            }
            isLoadingMore = false
        }
    }
    
    func navigateToStoryDetails(for story: Story) {
        coordinator.navigateToStoryDetails(story: story)
    }
}
