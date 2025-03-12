//
//  StoryEntity.swift
//  BeReal
//
//  Created by Vitaliy on 12.03.2025.
//
import SwiftData

@Model
class StoryEntity {
    var id: Int
    var name: String
    var profilePictureURL: String
    var isLiked: Bool
    var isSeen: Bool

    init(id: Int, name: String, profilePictureURL: String, isLiked: Bool = false, isSeen: Bool = false) {
        self.id = id
        self.name = name
        self.profilePictureURL = profilePictureURL
        self.isLiked = isLiked
        self.isSeen = isSeen
    }
}