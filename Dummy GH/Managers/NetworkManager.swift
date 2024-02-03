//
//  NetworkManager.swift
//  Dummy GH
//
//  Created by Vitaliy on 18.01.2024.
//

import UIKit


final class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "https://api.github.com/users/"
    let cache = NSCache<NSString, UIImage>()
    let decoder = JSONDecoder()
    
    private init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
    }
    
    //MARK: - Async/await version
    
    func dowloadImage(from urlString: String) async -> UIImage? {
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey) { return image }
        guard let url = URL(string: urlString) else { return nil }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: data) else { return nil }
            cache.setObject(image, forKey: cacheKey)
            return image
        } catch {
            return nil
        }
    }
    
    func getFollowers(for username: String, page: Int) async throws -> [Follower] {
        let endpoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            throw GHError.invalidUsername
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GHError.invalidResponse
        }
        
        do {
            return try decoder.decode([Follower].self, from: data)
        } catch {
            throw GHError.invalidData
        }
    }
    
    func getUserInfo(for username: String) async throws -> User {
        let endpoint = baseURL + "\(username)"
        
        guard let url = URL(string: endpoint) else {
            throw GHError.invalidUsername
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GHError.invalidResponse
        }
        
        do {
            return try decoder.decode(User.self, from: data)
        } catch {
            throw GHError.invalidData
        }
    }
    
    //MARK: - Completion Version
    
    //    func getFollowers(for username: String, page: Int, completion: @escaping (Result<[Follower], GHError>) -> Void) {
    //        let endpoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"
    //
    //        guard let url = URL(string: endpoint) else {
    //            completion(.failure(.invalidUsername))
    //            return
    //        }
    //
    //        let task = URLSession.shared.dataTask(with: url) { data, response, error in
    //            if let _ = error {
    //                completion(.failure(.unableToComplete))
    //                return
    //            }
    //
    //            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
    //                completion(.failure(.invalidResponse))
    //                return
    //            }
    //
    //            guard let data = data else {
    //                completion(.failure(.invalidData))
    //                return
    //            }
    //
    //            do {
    //                let decoder = JSONDecoder()
    //                decoder.keyDecodingStrategy = .convertFromSnakeCase
    //                let followers = try decoder.decode([Follower].self, from: data)
    //                completion(.success(followers))
    //            } catch {
    //                    completion(.failure(.invalidData))
    //            }
    //        }
    //        task.resume()
    //    }
    
    //    func getUserInfo(for username: String, completion: @escaping (Result<User, GHError>) -> Void) {
    //        let endpoint = baseURL + "\(username)"
    //
    //        guard let url = URL(string: endpoint) else {
    //            completion(.failure(.invalidUsername))
    //            return
    //        }
    //
    //        let task = URLSession.shared.dataTask(with: url) { data, response, error in
    //            if let _ = error {
    //                completion(.failure(.unableToComplete))
    //                return
    //            }
    //
    //            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
    //                completion(.failure(.invalidResponse))
    //                return
    //            }
    //
    //            guard let data = data else {
    //                completion(.failure(.invalidData))
    //                return
    //            }
    //
    //            do {
    //                let user = try self.decoder.decode(User.self, from: data)
    //
    //            } catch {
    //                completion(.failure(.invalidData))
    //            }
    //        }
    //        task.resume()
    //    }
    
    //    func dowloadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
    //        let cacheKey = NSString(string: urlString)
    //
    //        if let image = cache.object(forKey: cacheKey) {
    //            completion(image)
    //            return
    //        }
    //
    //        guard let url = URL(string: urlString) else {
    //            completion(nil)
    //            return
    //        }
    //
    //        let task = URLSession.shared.dataTask(with: url) { [ weak self ] data, response, error in
    //            guard let self = self,
    //                  error == nil,
    //                  let response = response as? HTTPURLResponse, response.statusCode == 200,
    //                  let data = data,
    //                  let image = UIImage(data: data) else {
    //                completion(nil)
    //                return
    //            }
    //
    //            self.cache.setObject(image, forKey: cacheKey)
    //            completion(image)
    //        }
    //        task.resume()
    //    }
}
