// JokesPresenter.swift
// Created by Anastasiya Kudasheva on 08.03.2022

import Foundation

final class JokesPresenter {
	private var viewController: JokesTableViewController?
	
	private var jokesArray = [JokeDTO]()
	private let networkManager: INetworkManager

	init() {
		self.networkManager = NetworkManager()
	}

	func loadVC(_ vc: JokesTableViewController) {
		self.viewController = vc
		self.viewController?.loadEmptyView()
	}

	func loadJokesButtonTapped(_ searchText: String?) {
		guard let searchText = searchText,
			  let searchInt = Int(searchText)
		else {
			self.presentError(Application.notNumber)
			return
		}

		if searchInt != 0 {
			networkManager.getJokes(numberOfJokes: searchInt) { [weak self] result in
				guard let self = self else { return }
				switch result {
				case .success(let array):
					self.jokesArray = array
					self.viewController?.loadViewWithData()
					self.viewController?.reloadTableView()
				case .failure(let error):
					self.presentError(error)
				}
			}
		} else {
			self.presentError(Application.noJokesCount)
		}
	}

	func returnCellCount() -> Int {
		self.jokesArray.count
	}

	func jokeForCell(at indexPath: IndexPath) -> String {
		return JokeViewModel(dto: self.jokesArray[indexPath.row]).joke
	}
}

private extension JokesPresenter {
	func presentError(_ error: AppError) {
		self.viewController?.loadEmptyView()
		self.viewController?.showErrorAlert(error.humanFriendlyMessage)
	}
}
