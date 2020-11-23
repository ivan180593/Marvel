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
    private var characterList = [CharacterListModel.ViewModel]()
    
    init(view: CharacterListViewProtocol, interactor: CharacterListInteractorProtocol) {
        self.view = view
        self.interactor = interactor
    }
}

// MARK: CharacterListPresenterProtocol
extension CharacterListPresenter: CharacterListPresenterProtocol {
    func getCharacters() {
        interactor.getCharacterList()
    }
    
    func characterListSuccess(response: CharacterListModel.NetworkResponse) {
        characterList = response.data.results.map {
            CharacterListModel.ViewModel(name: $0.name, id: $0.id)
        }
        view?.characterList(list: characterList)
    }
    
    func characterListFailure(error: String) {
        view?.showError(error)
    }
}
