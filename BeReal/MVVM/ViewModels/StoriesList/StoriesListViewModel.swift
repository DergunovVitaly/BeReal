//
//  StoriesListViewModel.swift
//  BeReal
//
//  Created by Vitaliy on 12.03.2025.
//

import SwiftUI
import SwiftData

class StoriesListViewModel: BaseViewModel {
   
    @Published var stories: [StoryEntity] = []
    @Published var errorMessage: String?
    @Published var isLoadingMore = false

    private var currentPage = 1
    private let pageSize = 10

    override init(coordinator: AppCoordinator, context: ModelContext) {
        super.init(coordinator: coordinator, context: context)
           Task {
               await loadStories()
           }
       }

    @MainActor
    func loadStories() async {
        let request = FetchDescriptor<StoryEntity>()

        do {
            let storedStories = try context.fetch(request)
            if !storedStories.isEmpty {
                self.stories = storedStories
                return
            }

            let result = try await NetworkService.shared.fetchStories()
            switch result {
            case .success(let loadedStories):
                saveStoriesToDatabase(loadedStories)
                self.stories = try context.fetch(request)
            case .failure(let error):
                self.errorMessage = "Error loading stories: \(error)"
            }
        } catch {
            self.errorMessage = "Error fetching stories: \(error.localizedDescription)"
        }
    }
    
    @MainActor
    func loadMoreStories() async {
        guard !isLoadingMore else { return }
        isLoadingMore = true
        
        do {
            let result = try await NetworkService.shared.fetchStories(page: currentPage + 1, pageSize: pageSize)
            switch result {
            case .success(let newStories):
                if !newStories.isEmpty {
                    saveStoriesToDatabase(newStories)
                    self.stories = try context.fetch(FetchDescriptor<StoryEntity>())
                    self.currentPage += 1
                }
            case .failure(let error):
                self.errorMessage = "Error loading more stories: \(error)"
            }
        } catch {
            self.errorMessage = "Error fetching more stories: \(error.localizedDescription)"
        }
        
        isLoadingMore = false
    }

    @MainActor
    func checkAndLoadMoreStories(currentStory: StoryEntity) {
        if let lastStory = stories.last, currentStory.id == lastStory.id, !isLoadingMore {
            Task {
                await loadMoreStories()
            }
        }
    }

    private func saveStoriesToDatabase(_ stories: [Story]) {
        do {
            let existingStories = try context.fetch(FetchDescriptor<StoryEntity>())
            let existingIDs = Set(existingStories.map { $0.id })

            for story in stories {
                if existingIDs.contains(story.id) { continue }
                let newStory = StoryEntity(id: story.id, name: story.name, profilePictureURL: story.profilePictureURL)
                context.insert(newStory)
            }
            try context.save()
        } catch {
            print("Error saving stories to database: \(error)")
        }
    }

    func markStoryAsSeen(_ story: StoryEntity) {
        story.isSeen = true
        do {
            try context.save()
        } catch {
            print("Error saving seen state: \(error)")
        }
    }

    func toggleLike(for story: StoryEntity) {
        story.isLiked.toggle()
        do {
            try context.save()
        } catch {
            print("Error saving like state: \(error)")
        }
    }
    
    func navigateToStoryDetails(for story: StoryEntity) {
        coordinator.navigateToStoryDetails(story: story, context: context)
    }
}
