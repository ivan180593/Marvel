//
//  CharacterDetailProtocols.swift
//  Marvel
//
//  Created by Iván Estévez Nieto on 12/11/2020.
//

import UIKit

// MARK: Wireframe
protocol CharacterDetailRouterProtocol: AnyObject {
    func back(from: UINavigationController?)
}

// MARK: Interactor
protocol CharacterDetailInteractorProtocol: AnyObject {
    var presenter: CharacterDetailPresenterProtocol? { get set }
    var worker: CharacterDetailWorkerProtocol { get }
    
    func getCharacterDetail(id: Int)
}

// MARK: Presenter
protocol CharacterDetailPresenterProtocol: AnyObject {
    var interactor: CharacterDetailInteractorProtocol { get }
    var view: CharacterDetailViewProtocol? { get }
    
    func viewDidLoad()
    func characterDetailSuccess(response: CharacterDetailModel.NetworkResponse)
    func characterDetailFailure(error: String)
}

// MARK: View
protocol CharacterDetailViewProtocol: AnyObject {
    var presenter: CharacterDetailPresenterProtocol? { get }
    var router: CharacterDetailRouterProtocol? { get }
    
    func characterDetail(detail: CharacterDetailModel.ViewModel)
    func showError(_ error: String)
}
