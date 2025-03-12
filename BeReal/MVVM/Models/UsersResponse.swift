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
}
