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
                case .success(let jsonValue):
                    do {
                        let data = try JSONSerialization.data(withJSONObject: jsonValue)
                        let breedsResponse = try JSONDecoder().decode(BreedsResponse.self, from: data)
                        completion(.success(breedsResponse.data))
                    }
                    catch {
                        completion(.failure(error))
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
