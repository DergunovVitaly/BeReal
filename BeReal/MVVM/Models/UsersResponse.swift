//
//  UsersResponse.swift
//  BeReal
//
//  Created by Vitaliy on 12.03.2025.
//

struct UsersResponse: Decodable {
    let pages: [Page]
}

struct Page: Decodable {
    let users: [User]
}

struct User: Decodable {
    let id: Int
    let name: String
    let profilePictureURL: String
    
    private enum CodingKeys: String, CodingKey {
        case id, name, profilePictureURL = "profile_picture_url"
    }
    
    var isSeen: Bool {
        get { UserDefaults.standard.bool(forKey: "seen_\(id)") }
        set { UserDefaults.standard.set(newValue, forKey: "seen_\(id)") }
    }
    
    var isLiked: Bool {
        get { UserDefaults.standard.bool(forKey: "liked_\(id)") }
        set { UserDefaults.standard.set(newValue, forKey: "liked_\(id)") }
    }
}
