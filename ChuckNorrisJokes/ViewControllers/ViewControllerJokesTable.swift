//
//  ViewControllerJokesTable.swift
//  ChuckNorrisJokes
//
//  Created by Анастасия Кудашева on 20.01.2021.
//

import UIKit

class ViewControllerJokesTable: UIViewController {
    
    @IBOutlet weak var jokesCountTextField: UITextField!
    @IBOutlet weak var jokesListTableView: UITableView!
    @IBOutlet weak var loadButton: UIButton!
    @IBOutlet weak var headImageView: UIImageView!
    
    var jokesArray = [JokesModel]()
    var networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        jokesCountTextField.delegate = self
        jokesListTableView.delegate = self
        jokesListTableView.dataSource = self
        
        // Hide keyboard and move view while textfield is editing
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        // Automatic cell height
        self.jokesListTableView.estimatedRowHeight = 56
        self.jokesListTableView.rowHeight = UITableView.automaticDimension
        
        // loadButton boarder
        loadButton.layer.cornerRadius = loadButton.frame.height / 2
        loadButton.layer.borderWidth = 1
        loadButton.layer.borderColor = UIColor.black.cgColor
    }
    
    @IBAction func loadJokesButton(_ sender: Any) {
        guard let search = jokesCountTextField.text else { return }
        let searchInt = Int(search) ?? 0
        
        if searchInt != 0 {
            networkManager.getJokes(numberOfJokes: search) { (jokesArray) in
                self.jokesArray = jokesArray
                DispatchQueue.main.async {
                    self.jokesListTableView.reloadData()
                }
            }
            headImageView.isHidden = true
            jokesCountTextField.endEditing(true)
        } else {
            presentAlertController()
        }
    }
}

