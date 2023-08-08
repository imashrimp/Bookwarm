//
//  KaKaoBookCollectionViewCell.swift
//  Bookwarm
//
//  Created by 권현석 on 2023/08/08.
//

import UIKit
import Kingfisher

class KaKaoBookCollectionViewCell: UICollectionViewCell {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var bookTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bookTitleLabel.numberOfLines = 0
        bookTitleLabel.font = .boldSystemFont(ofSize: 14)

    }

    func showBookContents(book: Book) {
        
        guard let imageUrl = URL(string: book.thumbnail) else {
            imageView.image = UIImage(systemName: "book.fill")
            return
        }
        imageView.kf.setImage(with: imageUrl)
        bookTitleLabel.text = book.title
    }
}