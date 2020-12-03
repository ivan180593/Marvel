//
//  CharacterDetailProtocols.swift
//  Marvel
//
//  Created by Iván Estévez Nieto on 12/11/2020.
//

import UIKit

// MARK: Presenter
protocol CharacterDetailPresenterProtocol: AnyObject {
    var view: CharacterDetailViewProtocol? { get }
    
    func getCharacter() -> CharacterModel.ViewModel
}

// MARK: View
protocol CharacterDetailViewProtocol: AnyObject {
    var presenter: CharacterDetailPresenterProtocol? { get }
}
