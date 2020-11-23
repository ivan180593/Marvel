//
//  CharacterDetailPresenter.swift
//  Marvel
//
//  Created by Iván Estévez Nieto on 12/11/2020.
//

import Foundation

final class CharacterDetailPresenter {
    private(set) var interactor: CharacterDetailInteractorProtocol
    private(set) weak var view: CharacterDetailViewProtocol?
    private let characterId: Int
    
    init(view: CharacterDetailViewProtocol, interactor: CharacterDetailInteractorProtocol, characterId: Int) {
        self.view = view
        self.interactor = interactor
        self.characterId = characterId
    }
}

// MARK: CharacterDetailPresenterProtocol
extension CharacterDetailPresenter: CharacterDetailPresenterProtocol {
    func viewDidLoad() {
        interactor.getCharacterDetail(id: characterId)
    }
    
    func characterDetailSuccess(response: CharacterDetailModel.NetworkResponse) {
        guard let firstResult = response.data.results.first else {
            view?.showError("No results")
            return
        }
        let detail = CharacterDetailModel.ViewModel(name: firstResult.name, description: firstResult.description, imagePath: firstResult.thumbnail.path + "." + firstResult.thumbnail.imageExtension)
        view?.characterDetail(detail: detail)
    }
    
    func characterDetailFailure(error: String) {
        view?.showError(error)
    }
}
