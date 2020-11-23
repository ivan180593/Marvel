//
//  UIImageViewExtensions.swift
//  Marvel
//
//  Created by Iván Estévez Nieto on 14/11/20.
//

import UIKit
import Combine

extension UIImageView {
    func fromUrl(_ path: String, placeholderName: String) -> AnyPublisher<UIImage?, Never> {
        guard let url = URL(string: path) else { return Just(nil).eraseToAnyPublisher() }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: UIImage(named: placeholderName))
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
