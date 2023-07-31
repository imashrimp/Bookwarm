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
    
    
    @IBOutlet var overviewLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = selectedMovie
    }

    func showsendedData() {
        // movie 인스턴스에서 selectedMovie를 받아와 필터링해서 Label에 이를 표시해보자
//        overviewLabel.text = movie.filter{ movie in
//            movie.title
//        }
    }
    
}
