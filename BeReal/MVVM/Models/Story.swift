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
    var isSeen: Bool {
        get {
            UserDefaults.standard.bool(forKey: "seen_\(id)")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "seen_\(id)")
        }
    }
    
    var isLiked: Bool {
        get {
            UserDefaults.standard.bool(forKey: "liked_\(id)")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "liked_\(id)")
        }
    }
}
