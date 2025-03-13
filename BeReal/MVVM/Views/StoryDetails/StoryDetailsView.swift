//
//  StoryDetailsView.swift
//  BeReal
//
//  Created by Vitaliy on 12.03.2025.
//
import SwiftUI
import SwiftData

struct StoryDetailsView: View {
    @ObservedObject var viewModel: StoryDetailsViewModel
    @State private var textOpacity: Double = 0.3
    @State private var textOffset: CGFloat = 0
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)

            VStack {
                HStack {
                    Button(action: {
                        viewModel.goBack()
                    }) {
                        Image(systemName: "arrow.left")
                            .font(.largeTitle)
                            .foregroundColor(.white)
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
                .padding(.bottom, 50)
                
                Text("Swipe up to go back")
                                    .font(Font.custom("Inter", size: 24))
                                    .foregroundColor(.white)
                                    .opacity(textOpacity)
                                    .offset(y: textOffset)
                                    .padding(.bottom, 16)
                                    .onAppear {
                                        withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                                            textOpacity = 1.0
                                            textOffset = 5
                                        }
                                    }

                Spacer()
            }
        }
        .onAppear {
            viewModel.markAsSeen()
        }
        .gesture(
            DragGesture().onEnded { value in
                if value.translation.height < 10 {
                    viewModel.goBack()
                }
            }
        )
    }
}
