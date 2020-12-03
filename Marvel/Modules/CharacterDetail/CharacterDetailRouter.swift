//
//  CharacterDetailRouter.swift
//  Marvel
//
//  Created by Iván Estévez Nieto on 12/11/2020.
//

import UIKit

final class CharacterDetailRouter {
    static func configure(_ vc: CharacterDetailViewController, character: CharacterModel.ViewModel, title: String) {
        let presenter = CharacterDetailPresenter(view: vc, character: character)
        vc.presenter = presenter
        vc.title = title
    }
}
