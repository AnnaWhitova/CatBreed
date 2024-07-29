//
//  MainViewController.swift
//  CatBreed
//
//  Created by Анна Белова on 20.07.2024.
//

import UIKit

final class MainViewController: UITableViewController {
    
    private let url = URL(string: "https://catfact.ninja/breeds")!
    private let networkManager = NetworkManager.shared
    private var breeds: [Breed] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        fetchBreeds()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return breeds.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "breedCell", for: indexPath)
        guard let cell = cell as? BreedCell else {  return UITableViewCell() }
        let breed = breeds[indexPath.row]
        cell.configure(with: breed)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Networking
extension MainViewController {
    private func fetchBreeds(){
        networkManager.fetchBreeds(from: url) { [weak self] result in
            switch result {
            case .success(let breeds):
                self?.breeds = breeds
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}
