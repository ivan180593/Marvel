//
//  CharacterListRouter.swift
//  Marvel
//
//  Created by Iván Estévez Nieto on 12/11/2020.
//

import UIKit

final class CharacterListRouter {
    struct Segue {
        static let detail = "detailSegue"
    }
    
    static func createMainModule() -> UIViewController {
        let navigationController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! UINavigationController
        let characterListViewController = navigationController.viewControllers.first! as! CharacterListViewController
        let worker = CharacterListWorker(manager: SessionManager.shared)
        let interactor = CharacterListInteractor(worker: worker)
        let router = CharacterListRouter()
        let presenter = CharacterListPresenter(view: characterListViewController, interactor: interactor)
        characterListViewController.presenter = presenter
        characterListViewController.router = router
        interactor.presenter = presenter

        return navigationController
    }
}

// MARK: CharacterListRouterProtocol
extension CharacterListRouter: CharacterListRouterProtocol {
    func showDetail(from: UIViewController) {
        from.performSegue(withIdentifier: CharacterListRouter.Segue.detail, sender: nil)
    }
    
    func configureDetail(_ vc: CharacterDetailViewController, characterId: Int, title: String) {
        CharacterDetailRouter.configure(vc, characterId: characterId, title: title)
    }
}
