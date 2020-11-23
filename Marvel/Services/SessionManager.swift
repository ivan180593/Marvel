//
//  SessionManager.swift
//  Marvel
//
//  Created by Iván Estévez Nieto on 12/11/2020.
//

import Foundation
import Combine

protocol SessionManagerProtocol {
    func get<T: Decodable>(path: String) -> AnyPublisher<T, Error>
}

final class SessionManager {
    static let shared = SessionManager()
    
    private let manager: URLSession
    private let baseUrl = "https://gateway.marvel.com:443/v1/public/"
    private let apiKey = "026b0cc153237e81932382d24217e302"
    private let hash = "b25d485e75ca98268a2a31909197fb05"
    
    init(manager: URLSession = URLSession.shared) {
        self.manager = manager
    }
}

// MARK: Private methods
private extension SessionManager {
    func resolveUrl(path: String) -> URL {
        let fullUrl = baseUrl + path + "?ts=1&apikey=" + apiKey + "&hash=" + hash
        return URL(string: fullUrl)!
    }
}

// MARK: SessionManagerProtocol
extension SessionManager: SessionManagerProtocol {
    func get<T: Decodable>(path: String) -> AnyPublisher<T, Error> {
        manager.publisher(for: resolveUrl(path: path))
    }
}
