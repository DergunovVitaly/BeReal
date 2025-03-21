//
//  ContentView.swift
//  BeReal
//
//  Created by Vitaliy on 12.03.2025.
//

//
//  ContentView.swift

import SwiftUI

struct ContentView: View {
    @ObservedObject var coordinator: AppCoordinator
    
    var body: some View {
        ZStack {
            switch coordinator.state {
            case .splash:
                SplashScreenView(coordinator: coordinator)
            case .storiesList(let vm):
                StoriesListView(viewModel: vm)
            case .storyDetails(let vm):
                StoryDetailsView(viewModel: vm)
            }
        }
    }
}
