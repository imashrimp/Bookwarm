//
//  BookDetailInfoViewController.swift
//  Bookwarm
//
//  Created by 권현석 on 2023/09/05.
//

import UIKit
import SnapKit
import RealmSwift

class BookDetailInfoViewController: UIViewController {
    
    var book: BookTable?
    
    let realm = try! Realm()
    
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
        view.isEditable = false
        view.isSelectable = false
        return view
    }()
    
    let memoTitleLabel = CustomLabel()
    let memoTextView = CustomTextView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(realm.configuration.fileURL)
        configure()
        setConstraints()
        
    }
    

    
    private func showNotSavedBookInfo() {
        
        guard
            let mybook = book,
            let author = mybook.author,
            let publisher = mybook.publisher,
            let price = mybook.price,
            let urlString = mybook.thumbnail else {
            return
        }
        
        titleLabel.text = "제목: \(mybook.title)"
        authorLabel.text = "저자: \(author)"
        publisherLabel.text = "출판사: \(publisher)"
        priceLabel.text = "가격: \(price)원"
        overViewTextView.text = mybook.overview
        
        guard let url = URL(string: urlString) else { return }
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url)
                DispatchQueue.main.async {
                    self.bookImage.image = UIImage(data: data)
                }
            } catch {
                print(error)
            }
        }
        
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
        
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
    }
    
    @objc func likeButtonTapped() {
        
        let realm = try! Realm()
        
        guard let bookData = book, let author = bookData.author else { return }
        

            
            let myBook = BookTable(isbn: bookData.isbn,
                                   title: bookData.title,
                                   author: author,
                                   publisher: bookData.publisher,
                                   thumbnail: bookData.thumbnail,
                                   overview: bookData.overview,
                                   price: bookData.price,
                                   memo: "")
            
            try! realm.write {
                realm.add(myBook)
            }
            
            likeButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            
            if bookImage.image != nil {
                saveImageToDocument(fileName: "imashrimp\(myBook._id).jpg", image: bookImage.image!)
            } else {
                
            }
            navigationController?.popViewController(animated: true)
        
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
