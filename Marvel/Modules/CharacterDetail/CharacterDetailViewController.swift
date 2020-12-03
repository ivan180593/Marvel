//
//  CharacterDetailViewController.swift
//  Marvel
//
//  Created by Iván Estévez Nieto on 12/11/2020.
//

import UIKit
import AlamofireImage

final class CharacterDetailViewController: UIViewController {
    @IBOutlet private weak var characterImageView: UIImageView!
    @IBOutlet private weak var characterNameLabel: UILabel!
    @IBOutlet private weak var characterDescriptionLabel: UILabel!
    @IBOutlet private weak var imageActivityIndicatorView: UIActivityIndicatorView!
    @IBOutlet private weak var descriptionActivityIndicatorView: UIActivityIndicatorView!
    
    var presenter: CharacterDetailPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

// MARK: Private methods
private extension CharacterDetailViewController {
    func setupView() {
        guard let character = presenter?.getCharacter() else { return }

        characterImageView.layer.masksToBounds = true
        characterImageView.layer.cornerRadius = characterImageView.frame.height / 2.0
        
        if let url = URL(string: character.path) {
            self.characterImageView.af.setImage(withURL: url, completion:  { [weak self](response) in
                self?.imageActivityIndicatorView.stopAnimating()
            })
        }
        self.descriptionActivityIndicatorView.stopAnimating()
        self.characterNameLabel.text = character.name
        self.characterDescriptionLabel.text = character.description.isEmpty ? "No description" : character.description
    }
}

// MARK: CharacterDetailViewProtocol
extension CharacterDetailViewController: CharacterDetailViewProtocol {
}
