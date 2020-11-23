//
//  CharacterDetailInteractor.swift
//  Marvel
//
//  Created by Iván Estévez Nieto on 12/11/2020.
//

import Foundation
import Combine

final class CharacterDetailInteractor {
    weak var presenter: CharacterDetailPresenterProtocol?
    private(set) var worker: CharacterDetailWorkerProtocol
    private var cancellable: AnyCancellable?

    init(worker: CharacterDetailWorkerProtocol) {
        self.worker = worker
    }
}

// MARK: CharacterDetailInteractorProtocol
extension CharacterDetailInteractor: CharacterDetailInteractorProtocol {
    func getCharacterDetail(id: Int) {
        cancellable = worker.getDetail(id: "\(id)").sink(receiveCompletion: { [weak self](result) in
            switch result {
            case .failure(let error):
                self?.presenter?.characterDetailFailure(error: error.localizedDescription)
            default:
                break
            }
        }, receiveValue: { [weak self](result) in
            self?.presenter?.characterDetailSuccess(response: result)
        })
    }
}
