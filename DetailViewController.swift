//
//  DetailViewController.swift
//  Bookwarm
//
//  Created by 권현석 on 2023/07/31.
//

//MARK: - 키보드 문제는 외부 라이브러리 사용해서 해결해보자

import UIKit

import Kingfisher

class DetailViewController: UIViewController {
    
    var transitionTypeID: TransitionID?
    var movieData = Movie(title: "", releaseDate: "", runtime: 0, overview: "", rate: 0, like: false, color: .black)
    var book: Book = Book(title: "", author: "", thumbnail: "", overview: "", price: 0, isbn: "")
    var textViewPlaceholder: String = "후기를 작성해주세요."
    
    @IBOutlet var moviePosterImage: UIImageView!
    @IBOutlet var movieTitleLabel: UILabel!
    @IBOutlet var releaseDateLabel: UILabel!
    @IBOutlet var runtimeLabel: UILabel!
    @IBOutlet var rateLabel: UILabel!
    @IBOutlet var overviewTitleLabel: UILabel!
    @IBOutlet var overviewTextView: UITextView!
    @IBOutlet var memoTitleLabel: UILabel!
    @IBOutlet var memoTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        memoTextView.delegate = self
        title = book.title
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
    }
    
    func configureLabel(label: UILabel, fontSize: CGFloat, fontWeight: UIFont.Weight, textColor: UIColor, textAlignment: NSTextAlignment ) {
        
        label.font = .systemFont(ofSize: fontSize, weight: fontWeight)
        label.textColor = textColor
        label.textAlignment = textAlignment
        label.numberOfLines = 0
    }
    
    func showsendedData() {
        
        guard let urlString = book.thumbnail, let imageUrl = URL(string: urlString) else {
            moviePosterImage.image = UIImage(systemName: "book.fill")
            return
        }
        moviePosterImage.kf.setImage(with: imageUrl)
        movieTitleLabel.text = movieData.title
        releaseDateLabel.text = "도서명: \(book.title)"
        runtimeLabel.text = "저자: \(book.author)"
        rateLabel.text = "정가: \(book.price)원"
        
        
        overviewTitleLabel.text = "줄거리"
        memoTitleLabel.text = "메모"
        overviewTextView.text = book.overview
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

    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == textViewPlaceholder {
            textView.text = nil
            textView.textColor = .black
        }
    }
}
