//
//  DetailViewController.swift
//  Bookwarm
//
//  Created by 권현석 on 2023/07/31.
//

import UIKit

class DetailViewController: UIViewController {

//    var selectedMovie: String = ""
//    var movie = MovieList().movie
    var selectedMovie: Movie?
    
    @IBOutlet var overviewLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = selectedMovie?.title
        
        configureLabel()
        showsendedData()
    }
    
    func configureLabel() {
        overviewLabel.numberOfLines = 0
    }
    
    func showsendedData() {
        overviewLabel.text = selectedMovie?.overview
    }
    
}
