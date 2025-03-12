//
//  BaseViewModel.swift
//  BeReal
//
//  Created by Vitaliy on 12.03.2025.
//

import SwiftUI
import SwiftData

class BaseViewModel: ObservableObject {
    
    let coordinator: AppCoordinator
    let context: ModelContext
    
    init(coordinator: AppCoordinator, context: ModelContext) {
        self.coordinator = coordinator
        self.context = context
    }
    
}
