//
//  BookWarmCollectionViewCell.swift
//  Bookwarm
//
//  Created by 권현석 on 2023/07/31.
//

import UIKit

class BookWarmCollectionViewCell: UICollectionViewCell {
    
    var randomColor: UIColor {
        UIColor(red: .random(in: 0...1),
                green: .random(in: 0...1),
                blue: .random(in: 0...1),
                alpha: 1)
    }
    
    @IBOutlet var movieTitleLabel: UILabel!
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var posterImageView: UIImageView!
    @IBOutlet var likeButton: UIButton!
    
    
    func configureCellAttribute() {
        self.layer.cornerRadius = 10
        //self.backgroundColor = randomColor
        
        movieTitleLabel.textColor = .white
        movieTitleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likeButton.setTitle("", for: .normal)
        likeButton.tintColor = .red
        
        ratingLabel.textColor = .white
        ratingLabel.font = .systemFont(ofSize: 20)
        
        posterImageView.contentMode = .scaleAspectFit
    }
    
    func setUIContents(movie: Movie) {
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
