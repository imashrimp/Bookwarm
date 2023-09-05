//
//  BookDetailInfoViewController.swift
//  Bookwarm
//
//  Created by 권현석 on 2023/09/05.
//

import UIKit
import SnapKit

class BookDetailInfoViewController: UIViewController {
    
    var book: Document?
    
    let bookImage = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let titleLabel = CustomLabel()
    let authorLabel = CustomLabel()
    let publisherLabel = CustomLabel()
    let priceLabel = CustomLabel()
    
    let likeButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "star"), for: .normal)
        view.tintColor = .systemYellow
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let overviewTitleLabel = CustomLabel()
    let overViewTextView = {
        let view = CustomTextView()
        view.isSelectable = false
        return view
    }()
    
    let memoTitleLabel = CustomLabel()
    let memoTextView = CustomTextView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setConstraints()
    }
    

    

}

extension BookDetailInfoViewController {
    
    func configure() {
        view.backgroundColor = .white
        tabBarController?.tabBar.isHidden = true
        
        [
        bookImage,
        titleLabel,
        authorLabel,
        publisherLabel,
        priceLabel,
        likeButton,
        overviewTitleLabel,
        overViewTextView,
        memoTitleLabel,
        memoTextView
        ].forEach {
            view.addSubview($0)
        }
        
        overviewTitleLabel.text = "줄거리"
        memoTitleLabel.text = "메모"
        
        guard let mybook = book, let author = mybook.authors.first else { return }
        
        titleLabel.text = "제목: \(mybook.title)"
        authorLabel.text = "저자: \(author)"
        publisherLabel.text = "출판사: \(mybook.publisher)"
        priceLabel.text = "가격: \(mybook.price)원"
        overViewTextView.text = mybook.contents
        
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
    }
    
    @objc func likeButtonTapped() {
        
    }
    func setConstraints() {
        bookImage.snp.makeConstraints { make in
            make.top.leading.equalTo(view.safeAreaLayoutGuide).offset(8)
            make.width.equalTo(UIScreen.main.bounds.width / 3)
            make.height.equalTo(UIScreen.main.bounds.height / 4.5)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(bookImage.snp.top)
            make.leading.equalTo(bookImage.snp.trailing).offset(12)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(12)
        }
        
        authorLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(6)
        }
        
        publisherLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(titleLabel)
            make.top.equalTo(authorLabel.snp.bottom).offset(6)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(titleLabel)
            make.top.equalTo(publisherLabel.snp.bottom).offset(6)
        }
        
        likeButton.snp.makeConstraints { make in
            make.bottom.equalTo(bookImage.snp.bottom)
            make.trailing.equalTo(titleLabel.snp.trailing)
            make.size.equalTo(44)
            make.top.greaterThanOrEqualTo(priceLabel.snp.bottom).offset(8)
        }
        
        overviewTitleLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(8)
            make.top.equalTo(bookImage.snp.bottom).offset(8)
        }
        
        overViewTextView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(8)
            make.top.equalTo(overviewTitleLabel.snp.bottom).offset(8)
            make.height.equalTo(UIScreen.main.bounds.height / 3.5)
        }
        
        memoTitleLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(8)
            make.top.equalTo(overViewTextView.snp.bottom).offset(8)
        }
        
        memoTextView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(8)
            make.top.equalTo(memoTitleLabel.snp.bottom).offset(8)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(8)
        }
    }
    
}
