//
//  ViewController.swift
//  Desafio - Mobile
//
//  Created by Guilherme de Almeida Henna on 23/10/18.
//  Copyright © 2018 Guilherme de Almeida Henna. All rights reserved.
//

import UIKit
import Moya_ModelMapper

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var movies = [Movie]()
    var upToDate = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showBlurLoader()
        /*
        let movie1 = Movie(id: 1, vote_average: 8.6, title: "Intocáveis", poster_url: "", genres: ["Drama", "Biografia"], release_date: "01-01-2012")
        let movie2 = Movie(id: 2, vote_average: 7.9, title: "Hércules", poster_url: "", genres: ["Comédia", "Musical"], release_date: "05-06-1998")
        let movie3 = Movie(id: 3, vote_average: 6.7, title: "Um espaço entre nós", poster_url: "", genres: ["Drama", "Ficção Científica"], release_date: "25-08-2001")
        
        movies.append(movie1)
        movies.append(movie2)
        movies.append(movie3)
 
        print("Contagem de Filmes: \(movies.count)")
        tableView.reloadData()
         */
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if !upToDate {
            checkConnection()
            upToDate = true
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = movies[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as? MovieCell {
            cell.configureCell(movie)
            return cell
        }
        return MovieCell()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detalhes = self.storyboard?.instantiateViewController(withIdentifier: "DetalhesVC") as! DetalhesVC
        detalhes.movieId = movies[indexPath.row].id
        show(detalhes, sender: self)
    }
    
    func Alert(Message: String) {
        let alert = UIAlertController(title: "Connection Error", message: Message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Try again", style: UIAlertActionStyle.default, handler: { (action) in
            self.checkConnection()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func checkConnection() {
        if !InternetCheck.Connection() {
            self.Alert(Message: "Check your internet connection and try again")
        }
        else {
            downloadData()
        }
    }
    
    func downloadData() {
        NetworkAdapter.request(target: .movies, success: { (response) in
            do {
                let moviesAux = try response.map(to: [Movie].self)
                for x in 0..<moviesAux.count {
                    // print(moviesAux[x].title)
                    self.movies.append(moviesAux[x])
                }
                // print(self.movies.count)
                self.tableView.reloadData()
                self.tableView.removeBlurLoader()
            } catch {
                print("Parsing Error")
            }
        }, error: { (error) in
            print("Server Error: \(error)")
        }, failure: { (error) in
            print("Moya Error: \(error)")
        })
    }

}

