//
//  NetworkService.swift
//  BeReal
//
//  Created by Vitaliy on 12.03.2025.
//

import Foundation

class NetworkService {
    static let shared = NetworkService()
    
    private init() { }
    
    enum NetworkError: Error {
        case fileNotFound
        case dataLoadingError(Error)
        case decodingError(Error)
    }
    
    func fetchStories(page: Int = 1, pageSize: Int = 10) async -> Result<[Story], NetworkError> {
       
        try? await Task.sleep(nanoseconds: UInt64(1_000_000_000))

        guard let url = Bundle.main.url(forResource: "users", withExtension: "json") else {
            return .failure(.fileNotFound)
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let usersResponse = try decoder.decode(UsersResponse.self, from: data)

            let allStories = usersResponse.pages
                .flatMap { $0.users }
                .map { Story(id: $0.id, name: $0.name, profilePictureURL: $0.profilePictureURL) }

            let startIndex = (page - 1) * pageSize
            let endIndex = min(startIndex + pageSize, allStories.count)

            guard startIndex < allStories.count else { return .success([]) }

            let paginatedStories = Array(allStories[startIndex..<endIndex])

            return .success(paginatedStories)
        } catch let error as DecodingError {
            return .failure(.decodingError(error))
        } catch {
            return .failure(.dataLoadingError(error))
        }
    }
}
