//
//  KaKaoBookCollectionViewCell.swift
//  Bookwarm
//
//  Created by 권현석 on 2023/08/08.
//

import UIKit
import Kingfisher

class KaKaoBookCollectionViewCell: UICollectionViewCell {

//    @IBOutlet var imageView: UIImageView!
//    @IBOutlet var bookTitleLabel: UILabel!
    
    let imageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
//        view.backgroundColor = .lightGray
//        view.layer.cornerRadius = 8
        return view
    }()
    
    let bookTitlelabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 15, weight: .bold)
        view.numberOfLines = 0
        view.textAlignment = .center
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(bookTitlelabel)
        
        configure()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        contentView.backgroundColor = .lightGray
        contentView.layer.cornerRadius = 15 //MARK: - 이거 여기서 하는거 맞나 모르겠네...
    }
    
    func setConstraints() {
        imageView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalToSuperview()
            make.height.equalTo(130)
        }
        
        bookTitlelabel.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(8)
        }
    }
    
//    func dtoTest(dtoData: TotalBook) {
//        guard let urlString = dtoData.thumbnail,  let imageUrl = URL(string: urlString) else {
//            imageView.image = UIImage(systemName: "book.fill")
//            return
//        }
//        imageView.kf.setImage(with: imageUrl)
//        bookTitleLabel.text = dtoData.title
//    }
    

//    func showBookContents(book: Book/*TotalBook*/) {
//
//        guard let urlString = book.thumbnail,  let imageUrl = URL(string: urlString) else {
//            imageView.image = UIImage(systemName: "book.fill")
//            return
//        }
//        imageView.kf.setImage(with: imageUrl)
//        bookTitleLabel.text = book.title
//    }
//
//
//    func showSavedBookContents(book: BookTable) {
//        guard let urlString = book.thumbnail,  let imageUrl = URL(string: urlString) else {
//            imageView.image = UIImage(systemName: "book.fill")
//            return
//        }
//        imageView.kf.setImage(with: imageUrl)
//        bookTitleLabel.text = book.title
//    }
}
