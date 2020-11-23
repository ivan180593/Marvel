//
//  CharacterListPresenterTests.swift
//  MarvelTests
//
//  Created by Iván Estévez Nieto on 14/11/20.
//

import XCTest
import Combine
@testable import Marvel

final class CharacterListPresenterTests: XCTestCase {
    private let worker = FakeWorker()
    private var interactor: FakeInteractor!
    private var presenter: FakePresenter!
    private var view = CharacterListViewController()
    
    override func setUp() {
        super.setUp()
        interactor = FakeInteractor(worker: worker)
        presenter = FakePresenter(view: view, interactor: interactor)
    }

    func testCharactersSuccess() {
        let expectation = XCTestExpectation(description: "")
        presenter.completion = {
            expectation.fulfill()
        }
        presenter.getCharacters()
    }
}

extension CharacterListPresenterTests {
    final class FakePresenter: CharacterListPresenterProtocol {
        var interactor: CharacterListInteractorProtocol
        var view: CharacterListViewProtocol?
        var completion: (() -> ())?

        init(view: CharacterListViewProtocol, interactor: CharacterListInteractorProtocol) {
            self.view = view
            self.interactor = interactor
        }
        
        func getCharacters() {
            interactor.getCharacterList()
        }
        
        func characterListSuccess(response: CharacterListModel.NetworkResponse) {
            completion?()
        }
        
        func characterListFailure(error: String) {
            completion?()
        }
    }
}
