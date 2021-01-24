//
//  JokeTableViewCell.swift
//  ChuckNorrisJokes
//
//  Created by Анастасия Кудашева on 23.01.2021.
//

import UIKit

class JokeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var jokeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func updateCell(joke: JokesModel) {
        let string = joke.joke.replacingOccurrences(of: "&quot;", with: "\"")
        
        jokeLabel.text = string
    }

}
