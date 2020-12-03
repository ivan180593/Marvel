//
//  ListModel.swift
//  Marvel
//
//  Created by Iván Estévez Nieto on 13/11/20.
//

import Foundation

struct CharacterListDataModel: Decodable {
    let results: [CharacterListResultModel]
}

struct CharacterListResultModel: Decodable {
    let name: String
    let description: String
    let thumbnail: ThumbnailModel
}

struct ThumbnailModel: Decodable {
    let path: String
    let imageExtension: String
    
    enum CodingKeys: String, CodingKey {
        case path
        case imageExtension = "extension"
    }
}
