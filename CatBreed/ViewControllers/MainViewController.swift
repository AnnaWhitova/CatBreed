//
//  MainViewController.swift
//  CatBreed
//
//  Created by Анна Белова on 20.07.2024.
//

import UIKit

protocol NewBreedViewControllerDelegate: AnyObject {
    func createBreed(_ breed: Breed)
}

final class MainViewController: UITableViewController {
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
   
    private let networkManager = NetworkManager.shared
    private var breeds: [Breed] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchBreeds()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
       
    }
    
    override func  prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navigationVC = segue.destination  as? UINavigationController else {return}
        guard let newBreedVC = navigationVC.topViewController as? NewBreedViewController else {return}
        newBreedVC.delegate = self
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
    
    private func showAlert(withTitle title: String, andMessage message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

// MARK: - Networking
extension MainViewController {
    private func fetchBreeds(){
        networkManager.fetchBreeds(from: Links.breedURL.url) { [unowned self] result in
            switch result {
            case .success(let breeds):
                self.breeds = breeds
                tableView.reloadData()
                activityIndicator.stopAnimating()
            case .failure(let error):
                showAlert(withTitle: "Something went wrong", andMessage: error.localizedDescription)
            }
        }
    }
}

// MARK: NewBreedViewControllerDelegate
extension MainViewController: NewBreedViewControllerDelegate {
    func createBreed(_ breed: Breed) {
        networkManager.postBreed(to: Links.postRequest.url, with: breed) { [unowned self] result in
            switch result {
            case .success(let breed):
                breeds.append(breed)
                let indexPath = IndexPath(row: breeds.count - 1, section: 0)
                tableView.insertRows(at: [indexPath], with: .automatic)
            case .failure(let error):
                showAlert(withTitle: "Something went wrong", andMessage: error.localizedDescription)
            }
        }
    }
    
    
}
