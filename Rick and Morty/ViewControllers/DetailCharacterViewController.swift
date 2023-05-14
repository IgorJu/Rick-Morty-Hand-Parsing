//
//  DetailCharacterViewController.swift
//  Rick and Morty
//
//  Created by Igor on 09.05.2023.
//

import UIKit

final class DetailCharacterViewController: UIViewController {
    
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var characterImageView: UIImageView! {
        didSet {
            characterImageView.layer.cornerRadius = characterImageView.frame.height / 2
        }
    }
    
    private let networkManager = NetworkManager.shared
    private var spinnerView = UIActivityIndicatorView()
    
    var personage: Personage!
    
    //MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        title = personage.name
        descriptionLabel.text = personage.description
        setupBackgroundImage(with: "RickDetail")
        showSpinner(in: characterImageView)
        fetchImage()
    }
    
    //MARK: - Private methods
    private func showSpinner(in view: UIView) {
        spinnerView = UIActivityIndicatorView(style: .large)
        spinnerView.color = .white
        spinnerView.startAnimating()
        spinnerView.center = characterImageView.center
        spinnerView.hidesWhenStopped = true
        view.addSubview(spinnerView)
    }
    
    //MARK: - Networking
    private func fetchImage() {
        networkManager.fetchData(from: personage.image) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.characterImageView.image = UIImage(data: imageData)
                self?.spinnerView.stopAnimating()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

