//
//  NetworkManager.swift
//  GitHubFollowers
//
//  Created by Ahmad Ayman Mansour on 14/05/2023.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    private let baseUrl = "http://api.github.com/users/"
    
    private init(){}
    
    func getFollowers(for username: String ,page: Int ,completion: @escaping ([Follower]?,ErrorMessage?) -> Void ) {
        
        let endPoint = baseUrl + "\(username)/followers?per_page=30&page=\(page)"
        
        guard let url = URL(string: endPoint) else {
            completion(nil , .invalidUsername)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completion(nil , .unableToComplete)
            }
            
            guard let response = response as? HTTPURLResponse , response.statusCode == 200 else {
                    completion(nil,.invalidResponse)
                return
            }
            
            guard let data = data else {
                    completion(nil,.invalidData)
                return
            }
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completion(followers,nil)
            } catch {
                completion(nil,.invalidData)
            }
            
        }
        
        task.resume()
        
    }
    
}
