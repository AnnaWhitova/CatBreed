//
//  Breed.swift
//  CatBreed
//
//  Created by Анна Белова on 20.07.2024.
//

import Foundation

struct Breed: Codable {
    let breed: String
    let country: String
    let origin: String
    let coat: String
    let pattern: String
    
    init(breed: String, country: String, origin: String, coat: String, pattern: String) {
        self.breed = breed
        self.country = country
        self.origin = origin
        self.coat = coat
        self.pattern = pattern
    }
    
    init(breedData: [String: Any]) {
        breed = breedData["breed"] as? String ?? ""
        country = breedData["country"] as? String ?? ""
        origin = breedData["origin"] as? String ?? ""
        coat = breedData["coat"] as? String ?? ""
        pattern = breedData["pattern"] as? String ?? ""
    }
    
    static func getBreed(from jsonValue: Any) -> [Breed] {
        guard let breedsData = jsonValue as? [[String: Any]] else { return [] }
        return breedsData.map { Breed(breedData: $0) }
    }
}
    

struct BreedsResponse: Decodable {
    let data: [Breed]
    
}

struct Link: Decodable {
    let url: String?
    let label: String
    let active: Bool
}

struct CatBreedInfo: Decodable {
    let current_page: Int
    let data: [Breed]
    let first_page_url: String
    let from: Int
    let last_page: Int
    let last_page_url: String
    let links: [Link]
    let next_page_url: String
    let path: String
    let per_page: Int
    let prev_page_url: String?
    let to: Int
    let total: Int
}
