//
//  StoriesListView.swift
//  BeReal
//
//  Created by Vitaliy on 12.03.2025.
//

import SwiftUI
import SwiftData

struct StoriesListView: View {
    
    @ObservedObject var viewModel: StoriesListViewModel

    var body: some View {
        ZStack {
            if viewModel.isLoadingMore {
                ProgressView()
            }
            
            VStack {
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 16) {
                        ForEach(viewModel.stories.uniqued(), id: \.id) { storyEntity in
                            VStack {
                                StoryItemView(story: storyEntity)
                                    .onTapGesture {
                                        viewModel.navigateToStoryDetails(for: storyEntity)
                                    }
                                Button(action: {
                                    viewModel.toggleLike(for: storyEntity)
                                }) {
                                    Image(systemName: storyEntity.isLiked ? "heart.fill" : "heart")
                                        .font(.title2)
                                        .foregroundColor(storyEntity.isLiked ? .red : .gray)
                                }
                            }
                            .onAppear {
                                viewModel.checkAndLoadMoreStories(currentStory: storyEntity)
                            }
                        }
                    }
                    .padding()
                }
            }
            .onAppear {
                Task {
                    await viewModel.loadStories()
                }
            }
        }
    }
}
