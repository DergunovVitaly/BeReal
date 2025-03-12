//
//  SplashScreenViewModel.swift
//  BeReal
//
//  Created by Vitaliy on 12.03.2025.
//


import SwiftUI

class SplashScreenViewModel: ObservableObject {
    
    let coordinator: AppCoordinator
    
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
    
    func navigateToStoriesList() {
        let viewModel = StoriesListViewModel(coordinator: coordinator)
        coordinator.navigateToStoriesList(viewModel: viewModel)
    }
}
