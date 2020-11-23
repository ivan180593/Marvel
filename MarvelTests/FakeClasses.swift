//
//  FakeClasses.swift
//  MarvelTests
//
//  Created by Iván Estévez Nieto on 14/11/20.
//

import XCTest
import Combine
@testable import Marvel

enum TestError: Error {
    case mapError
}

final class FakeWorker: CharacterListWorkerProtocol {
    private let data = CharacterListModel.NetworkResponse(data: CharacterListDataModel(results: [CharacterListResultModel(id: 1, name: "", description: "", thumbnail: ThumbnailModel(path: "", imageExtension: ""))]))
    private let badData = CharacterListModel.NetworkResponse(data: CharacterListDataModel(results: []))
    
    func getList() -> AnyPublisher<CharacterListModel.NetworkResponse, Error> {
        return Just(data)
            .mapError({ (error) -> Error in
                TestError.mapError
            }).eraseToAnyPublisher()
    }
}

final class FakeInteractor: CharacterListInteractorProtocol {
    var presenter: CharacterListPresenterProtocol?
    var worker: CharacterListWorkerProtocol
    private var cancellable: AnyCancellable?
    
    init(worker: CharacterListWorkerProtocol) {
        self.worker = worker
    }
    
    func getCharacterList() {
        cancellable = worker.getList().sink { (result) in
            switch result {
            case .failure(_):
                XCTFail("Fail getting data")
            default:
                break
            }
        } receiveValue: { (result) in
            XCTAssertFalse(result.data.results.isEmpty)
        }
    }
}
