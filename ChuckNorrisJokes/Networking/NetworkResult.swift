// NetworkResult.swift
// Created by Anastasiya Kudasheva on 08.03.2022

enum NetworkResult {
	case success([JokeDTO])
	case failure(NetworkError)
}

enum NetworkError: AppError {
	case failUrl
	case emptyAnswer
	case formatError
	case clientsError
	case serverError
	case unknown

	var humanFriendlyMessage: String {
		switch self {
		case .failUrl: return "Uncorrect URL"
		case .emptyAnswer: return "Server not send data"
		case .formatError: return "Server send data in incorrect format"
		case .clientsError: return "Bad internet, try again later"
		case .serverError: return "Server error, try again later"
		case .unknown: return "Something wrong. Try again later"
		}
	}
}
