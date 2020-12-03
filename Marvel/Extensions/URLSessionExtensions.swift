//
//  URLSessionExtensions.swift
//  Marvel
//
//  Created by Iván Estévez Nieto on 12/11/2020.
//

import Foundation
import Combine

extension URLSession {
    func publisher<T: Decodable>(for url: URL, decoder: JSONDecoder = .init()) -> AnyPublisher<T, Error> {
        dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: T.self, decoder: decoder)
            .map{$0}
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

