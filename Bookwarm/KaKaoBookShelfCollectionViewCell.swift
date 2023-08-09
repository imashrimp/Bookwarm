//
//  KaKaoBookShelfCollectionViewCell.swift
//  Bookwarm
//
//  Created by 권현석 on 2023/08/08.
//

import UIKit
import Kingfisher

class KaKaoBookShelfCollectionViewCell: UICollectionViewCell {

    @IBOutlet var bookImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    func showBookImage(book: Book) {
        guard let imageUrl = URL(string: book.thumbnail) else {
            bookImageView.image = UIImage(systemName: "book.fill")
            return
        }
        bookImageView.kf.setImage(with: imageUrl)
    }
}
