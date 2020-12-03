//
//  CharacterListTableViewCell.swift
//  Marvel
//
//  Created by Iván Estévez Nieto on 27/11/20.
//

import UIKit

final class CharacterListTableViewCell: UITableViewCell {
    @IBOutlet private weak var characterImageView: UIImageView!
    @IBOutlet private weak var characterNameLabel: UILabel!
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        characterImageView.image = nil
        characterImageView.af.cancelImageRequest()
    }
    
    func setItem(_ item: CharacterModel.ViewModel) {
        characterNameLabel.text = item.name
        activityIndicatorView.isHidden = false
        activityIndicatorView.startAnimating()
        if let url = URL(string: item.path) {
            characterImageView.af.setImage(withURL: url, completion: { [weak self](response) in
                if case .success = response.result {
                    self?.activityIndicatorView.stopAnimating()
                }
            })
        }
    }
}

private extension CharacterListTableViewCell {
    func setupView() {
        characterImageView.layer.cornerRadius = characterImageView.frame.height / 2.0
    }
}
