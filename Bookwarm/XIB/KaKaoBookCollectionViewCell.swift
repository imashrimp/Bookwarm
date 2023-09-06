//
//  KaKaoBookCollectionViewCell.swift
//  Bookwarm
//
//  Created by 권현석 on 2023/08/08.
//

import UIKit
import Kingfisher

class KaKaoBookCollectionViewCell: UICollectionViewCell {

    let imageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
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
        contentView.layer.cornerRadius = 15
    }
    
    func setConstraints() {
        imageView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalToSuperview().offset(8)
            make.height.equalTo(130)
        }
        
        bookTitlelabel.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview().inset(8)
            make.top.equalTo(imageView.snp.bottom).offset(8)
        }
    }
}
