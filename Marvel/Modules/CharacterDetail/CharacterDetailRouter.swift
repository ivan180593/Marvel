//
//  CharacterDetailRouter.swift
//  Marvel
//
//  Created by Iván Estévez Nieto on 12/11/2020.
//

import UIKit

final class CharacterDetailRouter {
    static func configure(_ vc: CharacterDetailViewController, characterId: Int, title: String) {
        let worker = CharacterDetailWorker(manager: SessionManager.shared)
        let interactor = CharacterDetailInteractor(worker: worker)
        let router = CharacterDetailRouter()
        let presenter = CharacterDetailPresenter(view: vc, interactor: interactor, characterId: characterId)
        vc.presenter = presenter
        vc.router = router
        interactor.presenter = presenter
        vc.title = title
    }
}

// MARK: CharacterDetailRouterProtocol
extension CharacterDetailRouter: CharacterDetailRouterProtocol {
    func back(from: UINavigationController?) {
        from?.popViewController(animated: true)
    }
}
