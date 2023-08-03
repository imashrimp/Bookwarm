//
//  BookShelfCollectionViewCell.swift
//  Bookwarm
//
//  Created by 권현석 on 2023/08/02.
//

import UIKit

class BookShelfCollectionViewCell: UICollectionViewCell, CellConfigureProtocol {

    @IBOutlet var movieImageView: UIImageView!
    
    override func awakeFromNib() {
        movieImageView.contentMode = .scaleAspectFit
    }
    
    func showCellContents(movie: Movie) {
        movieImageView.image = UIImage(named: movie.title)
        self.backgroundColor = movie.color
    }
}
