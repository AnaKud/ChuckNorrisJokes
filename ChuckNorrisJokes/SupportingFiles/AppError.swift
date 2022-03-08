// AppError.swift
// Created by Anastasiya Kudasheva on 08.03.2022

protocol AppError {
	var humanFriendlyMessage: String { get }
}

enum Application: AppError {
	case noJokesCount
	case notNumber

	var humanFriendlyMessage: String {
		switch self {
		case .noJokesCount: return "You should add count of jokes to display it"
		case .notNumber: return "You should enter number of jokes"
		}
	}
}
