//
//  CharacterListWorker.swift
//  Marvel
//
//  Created by Iván Estévez Nieto on 12/11/2020.
//

import Foundation
import Combine

protocol CharacterListWorkerProtocol {
    func getList() -> AnyPublisher<CharacterModel.NetworkResponse, Error>
}

final class CharacterListWorker {
    private let manager: SessionManagerProtocol
    private let path = "characters"
    
    init(manager: SessionManagerProtocol) {
        self.manager = manager
    }
}


// MARK: CharacterListWorkerProtocol
extension CharacterListWorker: CharacterListWorkerProtocol {
    func getList() -> AnyPublisher<CharacterModel.NetworkResponse, Error> {
        manager.get(path: path)
    }
}
