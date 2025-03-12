//
//  Story.swift
//  BeReal
//
//  Created by Vitaliy on 12.03.2025.
//
import Foundation

struct Story: Identifiable, Hashable {
    let id: Int
    let name: String
    let profilePictureURL: String
    var isSeen: Bool
    var isLiked: Bool
}
