//
//  StoriesListView.swift
//  BeReal
//
//  Created by Vitaliy on 12.03.2025.
//

import SwiftUI

struct StoriesListView: View {
    @ObservedObject var viewModel: StoriesListViewModel

    var body: some View {
        VStack {
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 16) {
                    ForEach(viewModel.stories, id: \.id) { story in
                        VStack {
                            StoryItemView(story: story)
                                .onTapGesture {
                                    viewModel.navigateToStoryDetails(for: story)
                                }
                            Button(action: {
                                viewModel.toggleLike(for: story)
                            }) {
                                Image(systemName: story.isLiked ? "heart.fill" : "heart")
                                    .font(.title2)
                                    .foregroundColor(story.isLiked ? .red : .gray)
                            }
                        }
                        .onAppear {
                            viewModel.checkAndLoadMoreStories(currentStory: story)
                        }
                    }
                }
                .padding()
            }
        }
        .onAppear {
            viewModel.loadInitialStories()
        }
    }
}
