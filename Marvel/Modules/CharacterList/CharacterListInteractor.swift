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
    func getCharacterList() {
        cancellable = worker.getList().sink(receiveCompletion: { [weak self](result) in
            switch result {
            case .failure(let error):
                self?.presenter?.characterListFailure(error: error.localizedDescription)
            default:
                break
            }
        }, receiveValue: { [weak self](result) in
            self?.presenter?.characterListSuccess(response: result)
        })
    }
}
