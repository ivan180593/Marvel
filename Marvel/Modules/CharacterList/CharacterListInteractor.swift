//
//  CharacterListInteractor.swift
//  Marvel
//
//  Created by Iván Estévez Nieto on 12/11/2020.
//

import Foundation
import Combine

final class CharacterListInteractor {
    weak var presenter: CharacterListPresenterProtocol?
    private(set) var worker: CharacterListWorkerProtocol
    private var cancellable: AnyCancellable?
    
    init(worker: CharacterListWorkerProtocol) {
        self.worker = worker
    }
}

// MARK: CharacterListInteractorProtocol
extension CharacterListInteractor: CharacterListInteractorProtocol {
    func getCharacterList(completion: @escaping ((Result<CharacterModel.NetworkResponse, Error>) -> Void)) {
        cancellable = worker.getList().sink(receiveCompletion: { (result) in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            default:
                break
            }
        }, receiveValue: { (result) in
            completion(.success(result))
        })
    }
}
