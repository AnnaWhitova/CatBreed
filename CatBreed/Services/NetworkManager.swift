//
//  NetworkManager.swift
//  CatBreed
//
//  Created by Анна Белова on 28.07.2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchBreeds(from url: URL, completion: @escaping (Result<[Breed], NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }
        
            do {
                let dataModel = try JSONDecoder().decode(BreedsResponse.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(dataModel.data))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
