//
//  DetailViewController.swift
//  Bookwarm
//
//  Created by 권현석 on 2023/07/31.
//

import UIKit

class DetailViewController: UIViewController {
    
    //didSet써서 해보자
    
    var movieData = Movie(title: "", releaseDate: "", runtime: 0, overview: "", rate: 0, like: false, color: .black)
    
    var selectedMovie: String = ""
    var movie = MovieList().movie
    
    @IBOutlet var moviePosterImage: UIImageView!
    @IBOutlet var movieTitleLabel: UILabel!
    @IBOutlet var releaseDateLabel: UILabel!
    @IBOutlet var runtimeLabel: UILabel!
    @IBOutlet var rateLabel: UILabel!
    @IBOutlet var likeImage: UIImageView!
    @IBOutlet var overviewTitleLabel: UILabel!
    @IBOutlet var overviewTextView: UITextView!
    @IBOutlet var memoTitleLabel: UILabel!
    @IBOutlet var memoTextView: UITextView!
//    @IBOutlet var likeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = selectedMovie
        configureMovieImage()
        configureLabel(label: movieTitleLabel, fontSize: 20, fontWeight: .bold, textColor: .black, textAlignment: .left)
        configureLabel(label: releaseDateLabel, fontSize: 17, fontWeight: .regular, textColor: .black, textAlignment: .left)
        configureLabel(label: runtimeLabel, fontSize: 17, fontWeight: .regular, textColor: .black, textAlignment: .left)
        configureLabel(label: rateLabel, fontSize: 17, fontWeight: .bold, textColor: .black, textAlignment: .left)
        configureLabel(label: overviewTitleLabel, fontSize: 18, fontWeight: .bold, textColor: .black, textAlignment: .left)
        configureLabel(label: memoTitleLabel, fontSize: 18, fontWeight: .bold, textColor: .black, textAlignment: .left)
        configureTextView(textView: overviewTextView, fontSize: 17, editable: false, selectable: false, textAlignment: .left)
        configureTextView(textView: memoTextView, fontSize: 18, editable: true, selectable: true, textAlignment: .left)
        
        showsendedData()
    }
    
//    func configureLikeButton() {
//        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
//        likeButton.tintColor = .red
//    }
    
//    @objc func likeButtonTapped() {
//        movieData.like.toggle()
//
//        movieData.like ? ({self.likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)})() : ({self.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)})()
//    }
    
    func configureTextView(textView: UITextView, fontSize: CGFloat, editable: Bool, selectable: Bool, textAlignment: NSTextAlignment) {
        textView.textColor = .black
        textView.font = .systemFont(ofSize: fontSize)
        textView.isEditable = editable
        textView.isSelectable = selectable
        textView.textAlignment = textAlignment
    }
    
    func configureMovieImage() {
        moviePosterImage.contentMode = .scaleAspectFit
        likeImage.tintColor = .red
    }
    
    func configureLabel(label: UILabel, fontSize: CGFloat, fontWeight: UIFont.Weight, textColor: UIColor, textAlignment: NSTextAlignment ) {
        
        label.font = .systemFont(ofSize: fontSize, weight: fontWeight)
        label.textColor = textColor
        label.textAlignment = textAlignment
    }
    
    func showsendedData() {
        
        moviePosterImage.image = UIImage(named: movieData.title)
        movieTitleLabel.text = movieData.title
        releaseDateLabel.text = "개봉일: \(movieData.releaseDate)"
        runtimeLabel.text = "상영시간: \(movieData.runtime)분"
        rateLabel.text = "평점: \(movieData.rate)점"
        
        overviewTitleLabel.text = "줄거리"
        memoTitleLabel.text = "메모"
        overviewTextView.text = movieData.overview
        
//        movieData.like ? ({self.likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)})() : ({self.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)})()
        
        movieData.like ? ({self.likeImage.image = UIImage(systemName: "heart.fill")})() : ({self.likeImage.image = UIImage(systemName: "heart")})()
        
        
        
    }
}
