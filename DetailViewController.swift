//
//  DetailViewController.swift
//  Bookwarm
//
//  Created by 권현석 on 2023/07/31.
//

import UIKit

class DetailViewController: UIViewController {
    
    var selectedMovie: String = ""
    var movie = MovieList().movie
    //    var selectedMovie: Movie?
    
    @IBOutlet var overviewLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = selectedMovie
        
        configureLabel()
        showsendedData()
    }
    
    func configureLabel() {
        overviewLabel.numberOfLines = 0
    }
    
    func showsendedData() {
        
        guard let filteredMovie = movie.filter ({ $0.title == selectedMovie }).first else { return }
        
        overviewLabel.text = filteredMovie.overview
    }
}
