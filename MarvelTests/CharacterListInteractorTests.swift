//
//  MarvelTests.swift
//  MarvelTests
//
//  Created by Iván Estévez Nieto on 12/11/2020.
//

import XCTest
import Combine
@testable import Marvel

final class CharacterListInteractorTests: XCTestCase {
    private let worker = FakeWorker()
    private var interactor: FakeInteractor!
    
    override func setUp() {
        super.setUp()
        interactor = FakeInteractor(worker: worker)
    }

    func test() {
        interactor.getCharacterList()
    }
}
