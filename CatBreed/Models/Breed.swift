//
//  Breed.swift
//  CatBreed
//
//  Created by Анна Белова on 20.07.2024.
//

import Foundation

struct Breed: Decodable {
    let breed: String
    let country: String
    let origin: String
    let coat: String
    let pattern: String
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
