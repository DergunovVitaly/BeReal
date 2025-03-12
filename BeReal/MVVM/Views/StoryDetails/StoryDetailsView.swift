//
//  StoryDetailsView.swift
//  BeReal
//
//  Created by Vitaliy on 12.03.2025.
//
import SwiftUI

struct StoryDetailsView: View {
    @ObservedObject var viewModel: StoryDetailsViewModel
   
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)

            VStack {
                HStack {
                    Button(action: {
                        viewModel.coordinator.goBack()
                    }) {
                        Image(systemName: "arrowshape.backward.fill")
                            .font(.largeTitle)
                            .foregroundColor(.blue)
                    }
                    Spacer()
                }
                .padding()
                
                AsyncImage(url: URL(string: viewModel.story.profilePictureURL)) { image in
                    image.resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: 400)
                        .clipped()
                } placeholder: {
                    ProgressView()
                }

                Text(viewModel.story.name)
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()

                Button(action: {
                    viewModel.toggleLike()
                }) {
                    Image(systemName: viewModel.story.isLiked ? "heart.fill" : "heart")
                        .font(.largeTitle)
                        .foregroundColor(viewModel.story.isLiked ? .red : .gray)
                }
                .padding(.top, 8)

                Text("Swipe down to go back")
                    .font(.caption)
                    .foregroundColor(.white)
                    .padding(.bottom, 16)

                Spacer()
            }
        }
        .onAppear {
            viewModel.markAsSeen()
        }
        .gesture(
            DragGesture().onEnded { value in
                if value.translation.height > 100 {
                    viewModel.coordinator.goBack()
                }
            }
        )
    }
}
