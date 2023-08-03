//
//  DetailViewController.swift
//  Bookwarm
//
//  Created by 권현석 on 2023/07/31.
//

//MARK: - 키보드 문제는 외부 라이브러리 사용해서 해결해보자

import UIKit

class DetailViewController: UIViewController {
    
    var transitionTypeID: TransitionID?
    var movieData = Movie(title: "", releaseDate: "", runtime: 0, overview: "", rate: 0, like: false, color: .black)
    
    var textViewPlaceholder: String = "후기를 작성해주세요."
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        memoTextView.delegate = self
        title = selectedMovie
        configureMovieImage()
        configureLabel(label: movieTitleLabel, fontSize: 13, fontWeight: .bold, textColor: .black, textAlignment: .left)
        configureLabel(label: releaseDateLabel, fontSize: 13, fontWeight: .regular, textColor: .black, textAlignment: .left)
        configureLabel(label: runtimeLabel, fontSize: 13, fontWeight: .regular, textColor: .black, textAlignment: .left)
        configureLabel(label: rateLabel, fontSize: 13, fontWeight: .bold, textColor: .black, textAlignment: .left)
        configureLabel(label: overviewTitleLabel, fontSize: 13, fontWeight: .bold, textColor: .black, textAlignment: .left)
        configureLabel(label: memoTitleLabel, fontSize: 13, fontWeight: .bold, textColor: .black, textAlignment: .left)
        configureTextView(textView: overviewTextView, fontSize: 13, editable: false, selectable: false, textAlignment: .left)
        configureTextView(textView: memoTextView, fontSize: 13, editable: true, selectable: true, textAlignment: .left)
        
        showsendedData()
        configureDismissButton()
        
        memoTextView.text = textViewPlaceholder
    }
    
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
        
        movieData.like ? {self.likeImage.image = UIImage(systemName: "heart.fill")}() : {self.likeImage.image = UIImage(systemName: "heart")}()
    }
    
    func configureDismissButton() {
        //MARK: - 이거 이렇게 해도 되는건가?
        if transitionTypeID == TransitionID.present {
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(dismissDetailVC))
        }
    }
    
    @objc func dismissDetailVC() {
        dismiss(animated: true)
    }
}


extension DetailViewController: UITextViewDelegate {
    // 애초에 처음에 들어갈 때 textView에 들어갈 값이 있어야함.
    //
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == textViewPlaceholder {
            textView.text = nil
            textView.textColor = .black
        }
    }
}
