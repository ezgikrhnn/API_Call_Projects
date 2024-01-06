//
//  ViewController.swift
//  MoviesAPI
//
//  Created by Ezgi Karahan on 6.01.2024.
//

import UIKit

class HomePage: UIViewController {

    //MARK: PROPERTIES
    @IBOutlet weak var MoviesTableView: UITableView!
    let movieManager = MovieManager()
    var myMovie: [Movies]? {
        didSet{
            DispatchQueue.main.sync {
                self.MoviesTableView.reloadData()
            }
        }
    }
    
    //MARK: LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        
        MoviesTableView.delegate = self
        MoviesTableView.dataSource = self
        
        movieManager.fetchMovies{ (movies) in
            self.myMovie = movies.movies
            
        }
    }
    
    func configureTableView(){
        view.backgroundColor = .black
    }


}


extension HomePage : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return myMovie?.count ?? 0 ///eğer nilse hiçbir şey döndürme
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "moviesCell") as! MoviesCell
        guard let movie = myMovie?[indexPath.row] else { return UITableViewCell()}
        cell.textLabel?.text = "\(movie.title) -- \(movie.releaseYear)"
        return cell
    }
    
    
    
}

