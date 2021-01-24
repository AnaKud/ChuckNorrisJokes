//
//  JokesModel.swift
//  ChuckNorrisJokes
//
//  Created by Анастасия Кудашева on 22.01.2021.
//

import Foundation

class JokesModel: Codable {
    public var joke: String
    
    init(joke: String) {
        self.joke = joke
    }
}
