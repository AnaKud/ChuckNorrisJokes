//
//  ViewControllerJokesTable.swift
//  ChuckNorrisJokes
//
//  Created by Анастасия Кудашева on 20.01.2021.
//

import UIKit

class JokesTableViewController: UIViewController {
	@IBOutlet weak var jokesCountTextField: UITextField!
	@IBOutlet weak var jokesListTableView: UITableView!
	@IBOutlet weak var loadButton: UIButton!
	@IBOutlet weak var headImageView: UIImageView!

	private let presenter = JokesPresenter()

	override func viewDidLoad() {
		super.viewDidLoad()
		self.presenter.loadVC(self)
		self.setupDelegates()
		self.setupKeyBoardObservers()
		self.setupCellHeight()
		self.setupButtonLayer()
		self.setupTextFieldLayer()
	}
	
	@IBAction func loadJokesButtonTapped(_ sender: Any) {
		self.presenter.loadJokesButtonTapped(self.jokesCountTextField.text)
	}

	func reloadTableView() {
		DispatchQueue.main.async {
			self.jokesListTableView.reloadData()
		}
	}

	func loadEmptyView() {
		DispatchQueue.main.async {
			self.headImageView.isHidden = false
			self.jokesListTableView.isHidden = true
		}
	}

	func loadViewWithData() {
		DispatchQueue.main.async {
			self.headImageView.isHidden = true
			self.jokesListTableView.isHidden = false
		}
	}

	func showErrorAlert(_ message: String) {
		let alertController = UIAlertController(title: nil,
												message: message,
												preferredStyle: .alert)
		let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
		alertController.addAction(alertAction)
		self.present(alertController, animated: true)
	}
}

private extension JokesTableViewController {
	func setupDelegates() {
		self.jokesCountTextField.delegate = self
		self.jokesListTableView.delegate = self
		self.jokesListTableView.dataSource = self
	}

	func setupCellHeight() {
		self.jokesListTableView.estimatedRowHeight = 56
		self.jokesListTableView.rowHeight = UITableView.automaticDimension
	}

	func setupButtonLayer() {
		self.loadButton.layer.cornerRadius = loadButton.frame.height / 2
		self.loadButton.layer.borderWidth = 1
		self.loadButton.layer.borderColor = UIColor.black.cgColor
	}

	func setupTextFieldLayer() {
		self.jokesCountTextField.layer.cornerRadius = loadButton.frame.height / 2
		self.jokesCountTextField.layer.borderWidth = 1
		self.jokesCountTextField.layer.borderColor = UIColor.black.cgColor
		self.jokesCountTextField.layer.masksToBounds = true
	}

	func setupKeyBoardObservers() {
		let tap = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing))
		self.view.addGestureRecognizer(tap)
		
		NotificationCenter.default.addObserver(self,
											   selector: #selector(keyboardWillShow),
											   name: UIResponder.keyboardWillShowNotification,
											   object: nil)
		NotificationCenter.default.addObserver(self,
											   selector: #selector(keyboardWillHide),
											   name: UIResponder.keyboardWillHideNotification,
											   object: nil)
	}
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension JokesTableViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.presenter.returnCellCount()
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: CellName.jokeCell,
													   for: indexPath) as? JokeTableViewCell
		else { return UITableViewCell() }
		let jokeForCell = self.presenter.jokeForCell(at: indexPath)
		cell.updateCell(jokeForCell)
		return cell
	}
}

// MARK: - UITextFieldDelegate
extension JokesTableViewController: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		self.presenter.loadJokesButtonTapped(textField.text)
		return true
	}
}

// MARK: - Moving keyboard while editing textfield
@objc extension JokesTableViewController {
	func keyboardWillShow(notification: NSNotification) {
		if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
			if self.view.frame.origin.y == 0 {
				self.view.frame.origin.y -= keyboardSize.height * 2 / 3
			}
		}
	}

	func keyboardWillHide(notification: NSNotification) {
		if self.view.frame.origin.y != 0 {
			self.view.frame.origin.y = 0
		}
	}
}
