//
//  CharacterDetailViewController.swift
//  Marvel
//
//  Created by Iván Estévez Nieto on 12/11/2020.
//

import UIKit
import Combine

final class CharacterDetailViewController: UIViewController {
    @IBOutlet private weak var characterImageView: UIImageView!
    @IBOutlet private weak var characterNameLabel: UILabel!
    @IBOutlet private weak var characterDescriptionLabel: UILabel!
    @IBOutlet private weak var imageActivityIndicatorView: UIActivityIndicatorView!
    @IBOutlet private weak var descriptionActivityIndicatorView: UIActivityIndicatorView!
    
    private var imageViewCancellable: AnyCancellable?
    var presenter: CharacterDetailPresenterProtocol?
    var router: CharacterDetailRouterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.viewDidLoad()
    }
}

// MARK: CharacterDetailViewProtocol
extension CharacterDetailViewController: CharacterDetailViewProtocol {
    func characterDetail(detail: CharacterDetailModel.ViewModel) {
        imageViewCancellable = characterImageView.fromUrl(detail.imagePath, placeholderName: "placeholder").sink { [weak self](image) in
            self?.imageActivityIndicatorView.stopAnimating()
            self?.characterImageView.layer.masksToBounds = true
            if let height = self?.characterImageView.frame.height {
                self?.characterImageView.layer.cornerRadius = height / 2.0
            }
            self?.characterImageView.image = image
        }
        DispatchQueue.main.async {
            self.descriptionActivityIndicatorView.stopAnimating()
            self.characterNameLabel.text = detail.name
            self.characterDescriptionLabel.text = detail.description.isEmpty ? "No description" : detail.description
        }
    }
    
    func showError(_ error: String) {
        DispatchQueue.main.async {
            self.imageActivityIndicatorView.stopAnimating()
            self.descriptionActivityIndicatorView.stopAnimating()
            let alertController = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
            let acceptAction = UIAlertAction(title: "Retry", style: .default) { (alert) in
                self.router?.back(from: self.navigationController)
            }
            alertController.addAction(acceptAction)
            self.navigationController?.present(alertController, animated: true)
        }
    }
}
