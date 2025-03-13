//
//  SplashScreenViewModel.swift
//  BeReal
//
//  Created by Vitaliy on 12.03.2025.
//

import SwiftUI
import SwiftData

class SplashScreenViewModel: ObservableObject {
    
    let coordinator: AppCoordinator
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
    
    func navigateToStoriesList(context: ModelContext) {
        let viewModel = StoriesListViewModel(coordinator: coordinator, context: context)
        Task {
            await viewModel.loadStories()
        }
        coordinator.navigateToStoriesList(viewModel: viewModel)
    }
}
