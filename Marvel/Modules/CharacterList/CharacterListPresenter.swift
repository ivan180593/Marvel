//
//  CharacterListPresenter.swift
//  Marvel
//
//  Created by Iván Estévez Nieto on 12/11/2020.
//

import Foundation

final class CharacterListPresenter {
    private(set) var interactor: CharacterListInteractorProtocol
    private(set) weak var view: CharacterListViewProtocol?
    private var characterList = [CharacterModel.ViewModel]()
    
    init(view: CharacterListViewProtocol, interactor: CharacterListInteractorProtocol) {
        self.view = view
        self.interactor = interactor
    }
}

// MARK: CharacterListPresenterProtocol
extension CharacterListPresenter: CharacterListPresenterProtocol {
    func getCharacters() {
        interactor.getCharacterList { [weak self](result) in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.characterList = response.data.results.map {
                    CharacterModel.ViewModel(name: $0.name, path: $0.thumbnail.path + "." + $0.thumbnail.imageExtension, description: $0.description)
                }
                self.view?.characterList(list: self.characterList)
            case .failure(let error):
                self.view?.showError(error.localizedDescription)
            }
        }
    }
}
