//
//  CharacterDetailPresenter.swift
//  Marvel
//
//  Created by Iván Estévez Nieto on 12/11/2020.
//

import Foundation

final class CharacterDetailPresenter {
    private(set) weak var view: CharacterDetailViewProtocol?
    private let character: CharacterModel.ViewModel
    
    init(view: CharacterDetailViewProtocol, character: CharacterModel.ViewModel) {
        self.view = view
        self.character = character
    }
}

// MARK: CharacterDetailPresenterProtocol
extension CharacterDetailPresenter: CharacterDetailPresenterProtocol {
    func getCharacter() -> CharacterModel.ViewModel {
        character
    }
}
