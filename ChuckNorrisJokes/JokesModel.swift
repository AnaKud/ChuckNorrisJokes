// JokesModel.swift
// Created by Анастасия Кудашева on 22.01.2021.

import Foundation

class JokesResponseDTO: Codable {
	var value: [JokeDTO]
	var type: String

	init(value: [JokeDTO], type: String) {
		self.value = value
		self.type = type
	}
}

class JokeDTO: Codable {
	var joke: String
	
	init(joke: String) {
		self.joke = joke
	}
}

class JokeViewModel {
	var joke: String

	init(dto: JokeDTO) {
		self.joke = dto.joke.replacingOccurrences(of: "&quot;", with: "\"")
	}
}
