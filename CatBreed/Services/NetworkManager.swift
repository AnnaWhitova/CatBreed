//
//  NetworkManager.swift
//  CatBreed
//
//  Created by Анна Белова on 28.07.2024.
//

import Foundation
import Alamofire

enum Links {
    case  breedURL
    case postRequest
    
    var  url: URL {
        switch self {
        case .breedURL:
            return URL(string: "https://catfact.ninja/breeds")!
        case .postRequest:
            return URL(string: "https://jsonplaceholder.typicode.com/posts")!
        }
    }
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchBreeds(from url: URL, completion: @escaping (Result<[Breed], Error>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    if let json = value as? [String: Any],
                       let dataArray = json["data"] as? [[String: Any]] {
                        let breeds = Breed.getBreed(from: dataArray)
                        completion(.success(breeds))
                    } else {
                        completion(.failure(NSError(domain: "Invalid Data", code: -1, userInfo: nil)))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func postBreed(to url: URL, with parameters: Breed, completion: @escaping (Result<Breed, Error>) -> Void) {
        AF.request(url, method: .post, parameters: parameters,encoder: JSONParameterEncoder(encoder: JSONEncoder()))
            .validate()
            .responseDecodable(of: Breed.self) { dataResponse in
                switch dataResponse.result {
                case .success(let breed):
                    completion(.success(breed))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
