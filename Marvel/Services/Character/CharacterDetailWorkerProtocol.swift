//
//  CharacterDetailWorkerProtocol.swift
//  Marvel
//
//  Created by Iván Estévez Nieto on 12/11/2020.
//

import Foundation
import Combine

protocol CharacterDetailWorkerProtocol {
    func getDetail(id: String) -> AnyPublisher<CharacterDetailModel.NetworkResponse, Error>
}

final class CharacterDetailWorker {
    private let manager: SessionManagerProtocol
    private let path = "characters/"
    
    init(manager: SessionManagerProtocol) {
        self.manager = manager
    }
}

// MARK: Private methods
private extension CharacterDetailWorker {
    func resolvePath(id: String) -> String {
        path + id
    }
}


// MARK: CharacterDetailWorkerProtocol
extension CharacterDetailWorker: CharacterDetailWorkerProtocol {
    func getDetail(id: String) -> AnyPublisher<CharacterDetailModel.NetworkResponse, Error> {
        manager.get(path: resolvePath(id: id))
    }
}
