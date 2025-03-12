//
//  BeRealApp.swift
//  BeReal
//
//  Created by Vitaliy on 12.03.2025.
//

import SwiftUI
import SwiftData

@main
struct BeRealApp: App {
    @StateObject private var coordinator = AppCoordinator()
    
    var sharedModelContainer: ModelContainer = {
           let schema = Schema([StoryEntity.self])
           let container = try! ModelContainer(for: schema)
           return container
       }()
    
    var body: some Scene {
        WindowGroup {
            ContentView(coordinator: coordinator)
                .modelContainer(sharedModelContainer)
        }
    }
}
