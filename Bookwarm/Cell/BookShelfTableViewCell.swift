//
//  BookShelfTableViewCell.swift
//  Bookwarm
//
//  Created by 권현석 on 2023/08/02.
//

import UIKit

class BookShelfTableViewCell: UITableViewCell, CellConfigureProtocol {
    
    @IBOutlet var movieImageView: UIImageView!
    @IBOutlet var movieTitleLabel: UILabel!
    @IBOutlet var releaseDateLabel: UILabel!
    @IBOutlet var runtimeLabel: UILabel!
    @IBOutlet var rateLabel: UILabel!
    @IBOutlet var likeButton: UIButton!
    
    override func awakeFromNib() {
        movieImageView.contentMode = .scaleAspectFit
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likeButton.setTitle("", for: .normal)
        likeButton.tintColor = .red
        
        configureLabel(label: movieTitleLabel, fontSize: 17, textColor: .white, textAlignment: .left)
        configureLabel(label: releaseDateLabel, fontSize: 15, textColor: .white, textAlignment: .left)
        configureLabel(label: runtimeLabel, fontSize: 15, textColor: .white, textAlignment: .left)
        configureLabel(label: rateLabel, fontSize: 15, textColor: .white, textAlignment: .left)
    }
    
    func showCellContents(movie: Movie) {
        movieImageView.image = UIImage(named: movie.title)
        movieTitleLabel.text = movie.title
        releaseDateLabel.text = movie.releaseDate
        runtimeLabel.text = "\(movie.runtime)분"
        rateLabel.text = "\(movie.rate)점"
        
        self.backgroundColor = movie.color
        
        // 실행구문만 남아있는 클로저임. => 파라미터 타입, 리턴 타입 없음.
        movie.like ? {self.likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)}() : {self.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)}()
    }
    
    func configureLabel(label: UILabel, fontSize: CGFloat, textColor: UIColor, textAlignment: NSTextAlignment ) {
        
        label.font = .systemFont(ofSize: fontSize)
        label.textColor = textColor
        label.textAlignment = textAlignment
    }
    
}
