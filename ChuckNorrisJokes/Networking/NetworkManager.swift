// NetworkManager.swift
// Created by Анастасия Кудашева on 22.01.2021.

import Foundation

protocol INetworkManager {
	func getJokes(numberOfJokes: Int, completion: @escaping (NetworkResult) -> Void)
}

class NetworkManager { }

extension NetworkManager: INetworkManager {
	func getJokes(numberOfJokes: Int, completion: @escaping (NetworkResult) -> Void) {
		guard let url = self.makeURL(numberOfJokes) else { return completion(.failure(.failUrl)) }
		let task = URLSession(configuration: .default)
			.dataTask(with: url) { [weak self] (data, response, error) in
				guard let self = self else { return completion(.failure(.unknown)) }
				guard let data = data else { return completion(.failure(.emptyAnswer)) }
				self.handleResponseStatusCode(response, completion: completion)
				self.parce(data: data, completion: completion)
				if error != nil { completion(.failure(.unknown)) }
			}
		task.resume()
	}
}

private extension NetworkManager {
	func makeURL(_ numberOfJokes: Int) -> URL? {
		let urlString = "http://api.icndb.com/jokes/random/" + "\(numberOfJokes)"
		guard let url = URL(string: urlString) else { return nil }
		return url
	}

	func parce(data: Data, completion: @escaping (NetworkResult) -> Void) {
		do {
			let response = try JSONDecoder().decode(JokesResponseDTO.self, from: data)
			completion(.success(response.value))
		} catch {
			completion(.failure(.formatError))
		}
	}

	func handleResponseStatusCode(_ response: URLResponse?,
								  completion: @escaping (NetworkResult) -> Void) {
		guard let httpResponse = response as? HTTPURLResponse else { return }
		switch ResponseState(statusCode: httpResponse.statusCode) {
		case .info, .success, .redirect, .unknown: break
		case .clientsError: completion(.failure(.clientsError))
		case .serverError: completion(.failure(.serverError))
		}
	}
}
