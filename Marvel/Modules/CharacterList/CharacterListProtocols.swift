//
//  CharacterListProtocols.swift
//  Marvel
//
//  Created by Iván Estévez Nieto on 12/11/2020.
//

import UIKit

// MARK: Wireframe
protocol CharacterListRouterProtocol: AnyObject {
    func showDetail(from: UIViewController)
    func configureDetail(_ vc: CharacterDetailViewController, character: CharacterModel.ViewModel, title: String)
}

// MARK: Interactor
protocol CharacterListInteractorProtocol: AnyObject {
    var presenter: CharacterListPresenterProtocol? { get set }
    var worker: CharacterListWorkerProtocol { get }
    
    func getCharacterList(completion: @escaping ((Result<CharacterModel.NetworkResponse, Error>) -> Void))
}

// MARK: Presenter
protocol CharacterListPresenterProtocol: AnyObject {
    var interactor: CharacterListInteractorProtocol { get }
    var view: CharacterListViewProtocol? { get }
    
    func getCharacters()
}

// MARK: View
protocol CharacterListViewProtocol: AnyObject {
    var presenter: CharacterListPresenterProtocol? { get }
    var router: CharacterListRouterProtocol? { get }
    
    func characterList(list: [CharacterModel.ViewModel])
    func showError(_ error: String)
}
