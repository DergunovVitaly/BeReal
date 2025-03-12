//
//  AppState.swift
//  BeReal
//
//  Created by Vitaliy on 12.03.2025.
//


import SwiftUI

enum AppState {
    case splash
    case storiesList(StoriesListViewModel)
    case storyDetails(StoryDetailsViewModel)
}
