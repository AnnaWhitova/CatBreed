//
//  MainViewController.swift
//  CatBreed
//
//  Created by Анна Белова on 20.07.2024.
//

import UIKit

final class MainViewController: UITableViewController {
    
   private let url = URL(string: "https://catfact.ninja/breeds")!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchBreed()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
}

// MARK: - Networking
extension MainViewController {
    private func fetchBreed(){
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let breedInfo = try decoder.decode(CatBreedInfo.self, from: data)
                print(breedInfo)
            } catch let error {
             print(error)
            }
       
        }.resume()
    }
}
