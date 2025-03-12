//
//  SplashScreenView.swift
//  BeReal
//
//  Created by Vitaliy on 12.03.2025.
//

import SwiftUI

struct SplashScreenView: View {
    @ObservedObject var coordinator: AppCoordinator
    @StateObject private var viewModel: SplashScreenViewModel
    @Environment(\.modelContext) private var context
    
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
        _viewModel = StateObject(wrappedValue: SplashScreenViewModel(coordinator: coordinator))
    }
    
    var body: some View {
        Text("BeReal!")
            .font(.system(size: 55, weight: .bold))
            .foregroundColor(.gray)
        ProgressView()
            .onAppear {
                Task {
                    try? await Task.sleep(nanoseconds: 3_000_000_000)
                    viewModel.navigateToStoriesList(context: context)
                }
            }
    }
}

#Preview {
    SplashScreenView(coordinator: .init())
}
