//
//  CharacterModel.swift
//  Marvel
//
//  Created by Iván Estévez Nieto on 12/11/2020.
//

import Foundation

struct CharacterModel {
    struct NetworkResponse: Decodable {
        let data: CharacterListDataModel
    }
    
    struct ViewModel: Hashable {
        let name: String
        let path: String
        let description: String
    }
}
