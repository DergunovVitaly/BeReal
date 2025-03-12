//
//  AppCoordinator.swift
//  BeReal
//
//  Created by Vitaliy on 12.03.2025.
//


import SwiftUI

class AppCoordinator: ObservableObject {
    @Published var state: AppState = .splash
    @Published var errorMessage: String?
    
    private var navigationStack: [AppState] = []

    func navigate(to newState: AppState) {
        navigationStack.append(state)
        state = newState
    }

    func goBack() {
        guard !navigationStack.isEmpty else { return }
        state = navigationStack.removeLast()
    }

    func navigateToStoriesList(viewModel: StoriesListViewModel) {
        navigate(to: .storiesList(viewModel))
    }

    func navigateToStoryDetails(story: Story) {
        let viewModel = StoryDetailsViewModel(story: story, coordinator: self)
        navigate(to: .storyDetails(viewModel)) 
    }
}
