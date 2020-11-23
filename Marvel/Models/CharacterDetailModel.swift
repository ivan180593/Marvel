//
//  CharacterDetailModel.swift
//  Marvel
//
//  Created by Iván Estévez Nieto on 12/11/2020.
//

import Foundation

struct CharacterDetailModel {
    struct NetworkResponse: Decodable {
        let data: CharacterListDataModel
    }
    
    struct ViewModel {
        let name: String
        let description: String
        let imagePath: String
    }
}
