//
//  ExtensionViewControllerJokesTable.swift
//  ChuckNorrisJokes
//
//  Created by Анастасия Кудашева on 22.01.2021.
//

import UIKit

// MARK: - ViewControllerJokesTable extension for Table support
extension ViewControllerJokesTable: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jokesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "JokeCell", for: indexPath) as? JokeTableViewCell {
            cell.updateCell(joke: jokesArray[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}

// MARK: - ViewControllerJokesTable extension for moving keyboard while editing textfield
extension ViewControllerJokesTable: UITextFieldDelegate {
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height * 2 / 3
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}


// MARK: - ViewControllerJokesTable extension for Alert Controller
extension ViewControllerJokesTable {
    func presentAlertController() {
        let alertController = UIAlertController(title: nil, message: "You should add count of jokes to display it", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true)
    }
}
