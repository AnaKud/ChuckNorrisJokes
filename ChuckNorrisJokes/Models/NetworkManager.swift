//
//  NetworkManager.swift
//  ChuckNorrisJokes
//
//  Created by Анастасия Кудашева on 22.01.2021.
//

import Foundation

class NetworkManager {
    
    func getJokes(numberOfJokes: String, completion: @escaping ([JokesModel]) -> ()) {
        var jokesArray = [JokesModel]()
        
        let urlString = "http://api.icndb.com/jokes/random/" + numberOfJokes
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    
                    if let jokesResults = json["value"] as? NSArray {
                        
                        for joke in jokesResults {
                            if let jokeAttibute = joke as? [String: AnyObject] {
                                guard let jokeText = jokeAttibute["joke"] as? String else { return }
                                let newJoke = JokesModel(joke: jokeText)
                                jokesArray.append(newJoke)
                            }
                        }
                        completion(jokesArray)
                    }
                } catch {
                    print(error.localizedDescription)
                }
                if error != nil {
                    print(error!.localizedDescription)
                }
            }
        }
        task.resume()
    }
}
