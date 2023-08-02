//
//  BookShelfCollectionViewCell.swift
//  Bookwarm
//
//  Created by 권현석 on 2023/08/02.
//

import UIKit

class BookShelfCollectionViewCell: UICollectionViewCell {

    @IBOutlet var movieImageView: UIImageView!
    
    override func awakeFromNib() {
        movieImageView.contentMode = .scaleAspectFit
    }
    
    func showMovieImage(movie: Movie) {
        movieImageView.image = UIImage(named: movie.title)
    }
}