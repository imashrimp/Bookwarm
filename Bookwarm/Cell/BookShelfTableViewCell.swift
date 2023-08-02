//
//  BookShelfTableViewCell.swift
//  Bookwarm
//
//  Created by 권현석 on 2023/08/02.
//

import UIKit

class BookShelfTableViewCell: UITableViewCell {
    

    @IBOutlet var movieImageView: UIImageView!
    @IBOutlet var movieTitleLabel: UILabel!
    @IBOutlet var releaseDateLabel: UILabel!
    @IBOutlet var runtimeLabel: UILabel!
    @IBOutlet var rateLabel: UILabel!
//    @IBOutlet var likeImageView: UIImageView!
    @IBOutlet var likeButton: UIButton!
    
    
    override func awakeFromNib() {
        movieImageView.contentMode = .scaleAspectFit
        //        likeImageView.tintColor = .red
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likeButton.setTitle("", for: .normal)
        likeButton.tintColor = .red

        
        configureLabel(label: movieTitleLabel, fontSize: 17, textColor: .white, textAlignment: .left)
        configureLabel(label: releaseDateLabel, fontSize: 15, textColor: .white, textAlignment: .left)
        configureLabel(label: runtimeLabel, fontSize: 15, textColor: .white, textAlignment: .left)
        configureLabel(label: rateLabel, fontSize: 15, textColor: .white, textAlignment: .left)
    }
    
    func showData(movie: Movie) {
        movieImageView.image = UIImage(named: movie.title)
        movieTitleLabel.text = movie.title
        releaseDateLabel.text = movie.releaseDate
        runtimeLabel.text = "\(movie.runtime)분"
        rateLabel.text = "\(movie.rate)점"
        
        self.backgroundColor = movie.color
//        movie.like ? {self.likeImageView.image = UIImage(systemName: "heart.fill")}() : {self.likeImageView.image = UIImage(systemName: "heart")}()
        
        movie.like ? {self.likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)}() : {self.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)}()
    }
    
    func configureLabel(label: UILabel, fontSize: CGFloat, textColor: UIColor, textAlignment: NSTextAlignment ) {
        
        label.font = .systemFont(ofSize: fontSize)
        label.textColor = textColor
        label.textAlignment = textAlignment
    }
    
}
