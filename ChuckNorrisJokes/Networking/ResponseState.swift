// ResponseState.swift
// Created by Anastasiya Kudasheva on 08.03.2022

enum ResponseState {
	case info
	case success
	case redirect
	case clientsError
	case serverError
	case unknown

	init(statusCode: Int) {
		if statusCode >= 100, statusCode < 200 {
			self = .info
		}
		else if statusCode >= 200, statusCode < 300 {
			self = .success
		}
		else if statusCode >= 300, statusCode < 400 {
			self = .redirect
		}
		else if statusCode >= 400, statusCode < 500 {
			self = .clientsError
		}
		else if statusCode >= 400, statusCode < 500 {
			self = .serverError
		}
		else {
			self = .unknown
		}
	}
}
