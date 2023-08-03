//
//  BookWarmCollectionViewCell.swift
//  Bookwarm
//
//  Created by 권현석 on 2023/07/31.
//

import UIKit

class BookWarmCollectionViewCell: UICollectionViewCell, CellConfigureProtocol {
    
    @IBOutlet var movieTitleLabel: UILabel!
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var likeButton: UIButton!
    
    // awakeFromNib
    
    
    func configureCellAttribute() {
        self.layer.cornerRadius = 10
        
        movieTitleLabel.textColor = .white
        movieTitleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        
        likeButton.setTitle("", for: .normal)
        likeButton.tintColor = .red
        
        ratingLabel.textColor = .white
        ratingLabel.font = .systemFont(ofSize: 20)
        
        posterImageView.contentMode = .scaleAspectFit
    }
    
    func showCellContents(movie: Movie) {
        movieTitleLabel.text = movie.title
        ratingLabel.text = "\(movie.rate)점"
        posterImageView.image = UIImage(named: movie.title)
        
        self.backgroundColor = movie.color
        
        if movie.like == true {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
}
