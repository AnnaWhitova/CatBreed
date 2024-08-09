//
//  NewBreedViewController.swift
//  CatBreed
//
//  Created by Анна Белова on 08.08.2024.
//

import UIKit

class NewBreedViewController: UIViewController {

    @IBOutlet var breedTextField: UITextField!
    @IBOutlet var countryTextField: UITextField!
    @IBOutlet var originTextField: UITextField!
    @IBOutlet var coatTextField: UITextField!
    @IBOutlet var patternTextField: UITextField!
    
    weak var delegate: NewBreedViewControllerDelegate?
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        let breed = Breed(
            breed: breedTextField.text ?? "",
            country: countryTextField.text ?? "",
            origin: originTextField.text ?? "",
            coat: coatTextField.text ?? "",
            pattern: patternTextField.text ?? ""
        )
        delegate?.createBreed(breed)
        dismiss(animated: true)
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        dismiss(animated: true)
    }
}
